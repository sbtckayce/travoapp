import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import '/models/promo/promo_model.dart';
import '/cubits/booking/booking_cubit.dart';
import '/models/booking_flight/booking_flight_model.dart';
import '/models/info_flight/info_flight.dart';

import '../../models/flight/flight_model.dart';
import '../../models/guest/guest_model.dart';
import '../../utils/show_message_util.dart';
import '/localization/app_localization.dart';
import '/widgets/all_info_general_checkout_flight.dart';

import '../../config/app_router_name.dart';
import '../../models/card/card_model.dart';
import '../../models/contact/contact_model.dart';

import '../../widgets/widgets.dart';
import '../checkout_hotel/checkout_hotel_screen.dart';

class CheckoutFlightScreen extends StatefulWidget {
  const CheckoutFlightScreen({super.key, required this.infoFlightModel});
  final InfoFlightModel infoFlightModel;
  @override
  State<CheckoutFlightScreen> createState() => _CheckoutFlightScreenState();
}

class _CheckoutFlightScreenState extends State<CheckoutFlightScreen> {
  ValueNotifier<int> currentStep = ValueNotifier(0);

  ValueNotifier<RadioPayment> radioGroupPayment =
      ValueNotifier(RadioPayment.miniMarket);

  CardModel? resultAddCard;
  late ContactModel contactModel;
  late GuestModel guestModel;
  late String email;
  ContactModel? resultContact;
  PromoModel? resultPromo;
  late CardModel cardModel;

  late BookingCubit bookingCubit;

  late LocalAuthentication localAuth;

  late PromoModel promoModel;
  @override
  void initState() {
    super.initState();
    bookingCubit = BlocProvider.of<BookingCubit>(context);

    localAuth = LocalAuthentication();
  }

  controlsBuilder() {
    switch (currentStep.value) {
      case 0:
        return CustomButton(
          text: 'payment'.tr(context),
          onPressed: onPayment,
          size: const Size(double.infinity, 50),
        );
      case 1:
        return CustomButton(
          text: 'done'.tr(context),
          onPressed: onDone,
          size: const Size(double.infinity, 50),
        );
      case 2:
        return CustomButton(
          text: 'pay_now'.tr(context),
          onPressed: onPayNow,
          size: const Size(double.infinity, 50),
        );
    }
  }

  onPayment() {
    if (resultContact == null) {
      showMessages(
          'please_add_contact'.tr(context), ContentType.warning, context);
    } else {
      currentStep.value = currentStep.value + 1;
    }
  }

  onDone() {
    if (radioGroupPayment.value == RadioPayment.credit &&
        resultAddCard == null) {
      showMessages('please_add_card'.tr(context), ContentType.warning, context);
    } else {
      currentStep.value = currentStep.value + 1;
    }
  }

  onPayNow() async {
    try {
      bool auth = await localAuth.authenticate(
          localizedReason: 'Finger',
          options: const AuthenticationOptions(stickyAuth: false));
      if (auth) {
        BookingFlightModel bookingFlightModel = BookingFlightModel(
            flightId: widget.infoFlightModel.flightModel.uid,
            seatModel: widget.infoFlightModel.seatModel,
            email: email,
            guest: guestModel,
            promoCode: resultPromo != null ? promoModel : PromoModel.empty(),
            cardModel: resultAddCard != null ? cardModel : CardModel.empty(),
            createTime: DateTime.now(),
            typePayment: radioGroupPayment.value.name,
            price: totalCheckout());
        if (!mounted) return;
        bookingCubit.createBookingFlight(bookingFlightModel, context);
        bookingCubit.sendPushNotification(title: 'Booking flight', description: 'Success', context: context);
        FlightModel flightModel =
            generateNewSeat(widget.infoFlightModel.flightModel);

        bookingCubit.updateSeat(flightModel: flightModel, context: context);
      }
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }

  int generateSeatBusinessTextToNumber(String text) {
    int number = 0;
    switch (text) {
      case 'A':
        number = 0;
      case 'B':
        number = 1;
      case 'C':
        number = 2;
      case 'D':
        number = 3;
    }
    return number;
  }

  int generateSeatEconomyTextToNumber(String text) {
    int number = 0;
    switch (text) {
      case 'A':
        number = 0;
      case 'B':
        number = 1;
      case 'C':
        number = 2;
      case 'D':
        number = 3;
      case 'E':
        number = 4;
      case 'F':
        number = 5;
    }
    return number;
  }

  FlightModel generateNewSeat(FlightModel flightModel) {
    String textNumberSeat = widget.infoFlightModel.seatModel.name[0];
    String textNameSeat = widget.infoFlightModel.seatModel.name[1];
    Map<String, List<bool>> business = flightModel.listMapSeat[0];
    Map<String, List<bool>> economy = flightModel.listMapSeat[1];

    if (widget.infoFlightModel.seatModel.type == 'Business') {
      int numberNameSeat = generateSeatBusinessTextToNumber(textNameSeat);

      business[textNumberSeat]![numberNameSeat] = true;

      FlightModel flightModelNew = widget.infoFlightModel.flightModel
          .copyWith(listMapSeat: [business, economy]);

      return flightModelNew;
    } else {
      int numberNameSeat = generateSeatEconomyTextToNumber(textNameSeat);

      economy[textNumberSeat]![numberNameSeat] = true;

      FlightModel flightModelNew = widget.infoFlightModel.flightModel
          .copyWith(listMapSeat: [business, economy]);

      return flightModelNew;
    }
  }

  navigateToContact() async {
    resultContact = await context.pushNamed(
      AppRouterName.contactFlight,
    );
    if (resultContact != null) {
      email = resultContact!.email;

      guestModel = GuestModel(
          name: resultContact!.guestModel.name,
          email: resultContact!.guestModel.email,
          phone: resultContact!.guestModel.phone);
    }
  }

  navigateToPromo() async {
    resultPromo = await context.pushNamed(
      AppRouterName.promoFlight,
    );
    if (resultPromo != null) {
      promoModel = PromoModel(
          code: resultPromo!.code,
          endow: resultPromo!.endow,
          image: resultPromo!.image,
          price: resultPromo!.price);
    }
  }

  navigateToAddCard() async {
    resultAddCard = await context.pushNamed(
      AppRouterName.addCardFlight,
    );
    if (resultAddCard != null) {
      cardModel = CardModel(
          name: resultAddCard!.name,
          cardNumber: resultAddCard!.cardNumber,
          expDate: resultAddCard!.expDate,
          cvv: resultAddCard!.cvv,
          country: resultAddCard!.country);
    }
  }



  String resultTaxesAndFees() {
    if (widget.infoFlightModel.flightModel.price > 150) {
      return 'free';
    } else {
      return '15%';
    }
  }

  double generateStringTaxesToDouble() {
    String tax = resultTaxesAndFees();
    if (tax == 'free') {
      return 0.0;
    } else {
      return 0.15;
    }
  }

  double totalCheckout() {
    double re = resultPromo != null
        ? widget.infoFlightModel.flightModel.price +
            (widget.infoFlightModel.flightModel.price *
                generateStringTaxesToDouble()) -
            (widget.infoFlightModel.flightModel.price * resultPromo!.price)
        : widget.infoFlightModel.flightModel.price +
            (widget.infoFlightModel.flightModel.price *
                generateStringTaxesToDouble());
    return re;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 30,
              child: Stack(
                children: [
                  CustomHeader(title: 'checkout_name'.tr(context)),
                  Positioned.fill(
                    top: 120,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: ValueListenableBuilder(
                          valueListenable: currentStep,
                          builder: (context, value, child) {
                            return Stepper(
                              margin: EdgeInsets.zero,
                              type: StepperType.horizontal,
                              elevation: 0,
                              physics: const AlwaysScrollableScrollPhysics(),
                              currentStep: currentStep.value,
                              controlsBuilder: (context, details) {
                                return controlsBuilder();
                              },
                              steps: [
                                Step(
                                  state: currentStep.value == 0
                                      ? StepState.editing
                                      : StepState.disabled,
                                  isActive: currentStep.value >= 0,
                                  title: Text(
                                    'book_and_review'.tr(context),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                  ),
                                  content: Column(
                                    children: [
                                      InfoFlightInherit(
                                        widget.infoFlightModel,
                                        child: Container(
                                          height: 440,
                                          margin:
                                              const EdgeInsets.only(bottom: 20),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                          child: const Stack(
                                            children: [
                                              AllInfoGeneralCheckouFlight(),
                                              InfoPriceQuantityCheckoutFlight()
                                            ],
                                          ),
                                        ),
                                      ),
                                      ContactBoxInherit(
                                        resultContact,
                                        child: ContactBox(
                                          onPressed: navigateToContact,
                                        ),
                                      ),
                                      PromoBoxInherit(
                                        resultPromo,
                                        child: PromoCodeBox(
                                          onPressed: navigateToPromo,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Step(
                                    state: currentStep.value == 1
                                        ? StepState.editing
                                        : StepState.disabled,
                                    isActive: currentStep.value >= 1,
                                    title: Text('payment'.tr(context),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary)),
                                    content: Column(
                                      children: [
                                        RadioMiniMarket(
                                            radioGroupPayment:
                                                radioGroupPayment),
                                        RadioCreditInherit(
                                          radioGroupPayment,
                                          resultAddCard,
                                          navigateToAddCard,
                                          child: const RadioCredit(),
                                        ),
                                        RadioBank(
                                            radioGroupPayment:
                                                radioGroupPayment)
                                      ],
                                    )),
                                Step(
                                    state: currentStep.value == 2
                                        ? StepState.editing
                                        : StepState.disabled,
                                    isActive: currentStep.value >= 2,
                                    title: Text('confirm'.tr(context),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary)),
                                    content: InfoFlightInherit(
                                      widget.infoFlightModel,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 470,
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground),
                                            child: const Stack(
                                              children: [
                                                AllInfoGeneralCheckouFlight(),
                                                InfoBarcodeCheckoutFlight()
                                              ],
                                            ),
                                          ),
                                          PromoBoxInherit(resultPromo,
                                              child:
                                                  InfoTotalPriceCheckoutFlight(
                                                flightModel: widget
                                                    .infoFlightModel
                                                    .flightModel,
                                                taxes: resultTaxesAndFees(),
                                                total: totalCheckout(),
                                              )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ContactBoxInherit(resultContact,
                                              child: const ConfirmContact()),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          PromoBoxInherit(resultPromo,
                                              child: const ConfirmPromo()),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          RadioCreditInherit(radioGroupPayment,
                                              resultAddCard, navigateToAddCard,
                                              child: const ConfirmPayment()),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            );
                          },
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
