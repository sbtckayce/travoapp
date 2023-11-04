import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/localization/app_localization.dart';
import '/models/flight/flight_model.dart';
import '/models/info_flight/info_flight.dart';
import '/models/seat/seat_model.dart';
import '../../utils/show_message_util.dart';

import '/config/app_router_name.dart';

import '../../widgets/widgets.dart';

enum SeatType { business, economy }

class SelectSeatScreen extends StatefulWidget {
  const SelectSeatScreen({super.key, required this.flightModel});
  final FlightModel flightModel;
  @override
  State<SelectSeatScreen> createState() => _SelectSeatScreenState();
}

class _SelectSeatScreenState extends State<SelectSeatScreen> {
  late Map<String, List<bool>> mapBusinessSeat;
  late Map<String, List<bool>> mapEconomyClassSeat;

  @override
  void initState() {
    super.initState();
    mapBusinessSeat = widget.flightModel.listMapSeat[0];
    mapEconomyClassSeat = widget.flightModel.listMapSeat[1];
  }

  ValueNotifier<String> currentSeat = ValueNotifier('');
  ValueNotifier<String> currentTypeSeat = ValueNotifier('');

  navigateToCheckoutFlight() {
    if (currentSeat.value == '' && currentTypeSeat.value == '') {
      showMessages(
          'please_choose_seat'.tr(context), ContentType.warning, context);
    } else {
      SeatModel seatModel =
          SeatModel(name: currentSeat.value, type: currentTypeSeat.value);
      InfoFlightModel infoFlightModel = InfoFlightModel(
          flightModel: widget.flightModel, seatModel: seatModel);
      context.pushNamed(AppRouterName.checkoutFlight, extra: infoFlightModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 30,
          child: Stack(
            children: [
              SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    const BackGroundHeader(),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: CustomBackButton(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'select_seat'.tr(context),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                top: 100,
                child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 600,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: InfoAllSelectSeat(
                                            currentSeat: currentSeat,
                                            currentTypeSeat: currentTypeSeat,
                                            flightModel: widget.flightModel,
                                          )),
                                      Expanded(
                                        flex: 5,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 0,
                                              right: 128,
                                              child: Image.asset(
                                                'assets/images/seatLeft.png',
                                                width: 130,
                                                fit: BoxFit.fill,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Image.asset(
                                                'assets/images/seatRight.png',
                                                width: 130,
                                                fit: BoxFit.fill,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                              ),
                                            ),
                                            Positioned(
                                                top: 80,
                                                right: 54,
                                                child: Image.asset(
                                                  'assets/images/headerSeat.png',
                                                  width: 150,
                                                )),
                                            ShapeSelectSeatInherit(
                                              mapBusinessSeat,
                                              mapEconomyClassSeat,
                                              currentSeat,
                                              currentTypeSeat,
                                              child:
                                                  const ShapeSelectSeatBusiness(),
                                            ),
                                            ShapeSelectSeatInherit(
                                              mapBusinessSeat,
                                              mapEconomyClassSeat,
                                              currentSeat,
                                              currentTypeSeat,
                                              child:
                                                  const ShapeSelectSeatEconomy(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomButton(
                            text: 'processed'.tr(context),
                            size: const Size(double.infinity, 50),
                            onPressed: navigateToCheckoutFlight,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
