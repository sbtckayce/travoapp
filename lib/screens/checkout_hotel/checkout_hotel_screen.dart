

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:travoapps/constants/constants.dart';

import '../../models/promo/promo_model.dart';
import '/models/guest/guest_model.dart';
import '/localization/app_localization.dart';

import '/cubits/booking/booking_cubit.dart';
import '../../models/booking_hotel/booking_hotel_model.dart';
import '/models/card/card_model.dart';
import '/models/contact/contact_model.dart';
import '../../utils/show_message_util.dart';

import '/config/app_router_name.dart';

import '../../widgets/widgets.dart';
import '/models/room/room_model.dart';

enum RadioPayment { miniMarket, credit, bank }

class CheckoutHotelScreen extends StatefulWidget {
  const CheckoutHotelScreen(
      {super.key,
      required this.roomModel,
      required this.roomId,
      required this.hotelId});

  final RoomModel roomModel;
  final String roomId;
  final String hotelId;
  @override
  State<CheckoutHotelScreen> createState() => _CheckoutHotelScreenState();
}

class _CheckoutHotelScreenState extends State<CheckoutHotelScreen> {
  ValueNotifier<int> currentStep = ValueNotifier(0);
  ValueNotifier<DateTime> checkIn = ValueNotifier(DateTime.now());
  ValueNotifier<DateTime> checkOut = ValueNotifier(DateTime.now());
  ValueNotifier<RadioPayment> radioGroupPayment =
      ValueNotifier(RadioPayment.miniMarket);

  ContactModel? resultContact;
  PromoModel? resultPromo;
  CardModel? resultAddCard;

  late String email;

  late ContactModel contactModel;
  late GuestModel guestModel;
  late CardModel cardModel;
  late LocalAuthentication localAuth;
  late PromoModel promoModel;
  navigateToContact() async {
    resultContact = await context.pushNamed(AppRouterName.contactHotel,
        extra: widget.roomModel,
        pathParameters: {'hotelId': widget.hotelId, 'roomId': widget.roomId});
    if (resultContact != null) {
      email = resultContact!.email;

      guestModel = GuestModel(
          name: resultContact!.guestModel.name,
          email: resultContact!.guestModel.email,
          phone: resultContact!.guestModel.phone);
    }
  }

  navigateToPromo() async {
    resultPromo = await context.pushNamed(AppRouterName.promoHotel,
        extra: widget.roomModel,
        pathParameters: {'hotelId': widget.hotelId, 'roomId': widget.roomId});
    if (resultPromo != null) {
      promoModel = PromoModel(
          code: resultPromo!.code,
          endow: resultPromo!.endow,
          image: resultPromo!.image,
          price: resultPromo!.price);
    }
  }

  navigateToAddCard() async {
    resultAddCard = await context.pushNamed(AppRouterName.addCardHotel,
        extra: widget.roomModel,
        pathParameters: {'hotelId': widget.hotelId, 'roomId': widget.roomId});
    if (resultAddCard != null) {
      cardModel = CardModel(
          name: resultAddCard!.name,
          cardNumber: resultAddCard!.cardNumber,
          expDate: resultAddCard!.expDate,
          cvv: resultAddCard!.cvv,
          country: resultAddCard!.country);
    }
  }

  chooseCheckIn() async {
    final time = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 50));
    if (time != null) {
      checkIn.value = time;
    }
  }

  chooseCheckOut() async {
    final time = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 50));
    if (time != null) {
      checkOut.value = time;
    }
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
        return BlocBuilder<BookingCubit, BookingState>(
          builder: (context, state) {
            return CustomButton(
              text: 'pay_now'.tr(context),
              onPressed: onPayNow,
              size: const Size(double.infinity, 50),
            );
          },
        );
    }
  }

  late int numberDay = 1;
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  onPayment() {
    numberDay = daysBetween(checkIn.value, checkOut.value);
    if (resultContact == null) {
      showMessages(
          'please_add_contact'.tr(context), ContentType.warning, context);
    }

    if (numberDay <= 0) {
      showMessages(
          'check_out_large_check_in'.tr(context), ContentType.warning, context);
    } else if (resultContact != null && numberDay > 0) {
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
        BookingHotelModel bookingModel = BookingHotelModel(
            dateStart: checkIn.value,
            dateEnd: checkOut.value,
            email: email,
            hotelId: widget.hotelId,
            roomId: widget.roomId,
            guest: guestModel,
            promoCode: resultPromo != null ? promoModel : PromoModel.empty(),
            cardModel: resultAddCard != null ? cardModel : CardModel.empty(),
            typePayment: radioGroupPayment.value.name,
            price: totalCheckout());
        if (!mounted) return;
        bookingCubit.createBookingHotel(bookingModel, context);
        bookingCubit.sendPushNotification(
            title: 'Booking hotel', description: 'Success', context: context);
      }
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }

  late BookingCubit bookingCubit;
  @override
  void initState() {
    super.initState();
    bookingCubit = BlocProvider.of<BookingCubit>(context);

    localAuth = LocalAuthentication();
  }

  String resultTaxesAndFees() {
    if (numberDay * widget.roomModel.price > 300) {
      return 'free';
    } else {
      return '10%';
    }
  }

  double generateStringTaxesToDouble() {
    String tax = resultTaxesAndFees();
    if (tax == 'free') {
      return 0.0;
    } else {
      return 0.1;
    }
  }

  double totalCheckout() {
    double re = resultPromo != null
        ? numberDay * widget.roomModel.price +
            (numberDay *
                widget.roomModel.price *
                generateStringTaxesToDouble()) -
            (numberDay * widget.roomModel.price * resultPromo!.price)
        : numberDay * widget.roomModel.price +
            (numberDay *
                widget.roomModel.price *
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
                                            color: primaryColor),
                                  ),
                                  content: Column(
                                    children: [
                                      RoomItem(
                                          isCheckout: true,
                                          hotelId: widget.hotelId,
                                          roomModel: widget.roomModel),
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
                                      CheckTimeBoxInherit(
                                        checkIn,
                                        checkOut,
                                        chooseCheckIn,
                                        chooseCheckOut,
                                        child: const CheckTimeBox(),
                                      )
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
                                                color: primaryColor)),
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
                                                color: primaryColor)),
                                    content: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 20),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ConfirmInfoRoom(
                                                  roomModel: widget.roomModel),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              const DottedDash(),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              CheckTimeBoxInherit(
                                                checkIn,
                                                checkOut,
                                                chooseCheckIn,
                                                chooseCheckOut,
                                                child: const CheckTimeItem(
                                                    isConfirm: true),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        PromoBoxInherit(
                                          resultPromo,
                                          child: InfoTotalPriceCheckoutHotel(
                                            numberDay: numberDay,
                                            roomModel: widget.roomModel,
                                            total: totalCheckout(),
                                            taxes: resultTaxesAndFees(),
                                          ),
                                        ),
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
