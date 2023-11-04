import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/localization/app_localization.dart';
import '/models/search_flight/search_flight.dart';
import '/screens/select_seat/select_seat_screen.dart';
import '../../utils/show_message_util.dart';
import '../../config/app_router_name.dart';
import '/constants/constants.dart';
import '/widgets/book_flight_item.dart';

import '/widgets/widgets.dart';

class BookFlight extends StatefulWidget {
  const BookFlight({super.key});

  @override
  State<BookFlight> createState() => _BookFlightState();
}

class _BookFlightState extends State<BookFlight> {
  ValueNotifier<String> fromText1 = ValueNotifier('From place');
  ValueNotifier<String> toText1 = ValueNotifier('To place');

  ValueNotifier<DateTime> date1 = ValueNotifier(DateTime.now());

  ValueNotifier<SeatType> seatType1 = ValueNotifier(SeatType.business);

  ValueNotifier<String> fromText2 = ValueNotifier('From place');
  ValueNotifier<String> toText2 = ValueNotifier('To place');

  ValueNotifier<DateTime> date2 = ValueNotifier(DateTime.now());

  ValueNotifier<SeatType> seatType2 = ValueNotifier(SeatType.business);

  navigateToResultFlight() {
    if (fromText1.value == 'From place') {
      showMessages(
          'please_choose_from'.tr(context), ContentType.warning, context);
    }
    if (toText1.value == 'To place') {
      showMessages(
          'please_choose_to'.tr(context), ContentType.warning, context);
    }
    if (fromText1.value == toText1.value) {
      showMessages(
          'from_to_different'.tr(context), ContentType.warning, context);
    } else if (fromText1.value != 'From place' &&
        toText1.value != 'To place' &&
        fromText1.value != toText1.value) {
      SearchFlightModel searchFlightModel = SearchFlightModel(
          fromPlace: fromText1.value,
          toPlace: toText1.value,
          date: date1.value,
          numberPassenger: 1,
          seatType: seatType1.value.name);
      context.pushNamed(AppRouterName.resultFlight, extra: searchFlightModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            CustomHeader(title: 'book_flight'.tr(context)),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TabBar(
                  dividerColor: Colors.transparent,
                  indicatorPadding: EdgeInsets.zero,
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  labelColor: Theme.of(context).colorScheme.onBackground,
                  unselectedLabelColor: primaryColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 0,
                  indicator: BoxDecoration(
                      color: orangeSpice,
                      borderRadius: BorderRadius.circular(15)),
                  tabs: [
                    CustomTabFlight(name: 'one_way'.tr(context)),
                    CustomTabFlight(name: 'round_trip'.tr(context)),
                    CustomTabFlight(name: 'multi_city'.tr(context)),
                  ]),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: ListView(
                        children: [
                          BookFlightInherit(
                            fromText1,
                            toText1,
                            date1,
                            seatType1,
                            child: const BookFlightItem(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            text: 'search'.tr(context),
                            onPressed: () {
                              navigateToResultFlight();
                            },
                            size: const Size(double.infinity, 50),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListView(
                      children: [
                        BookFlightInherit(
                          fromText1,
                          toText1,
                          date1,
                          seatType1,
                          child: const BookFlightItem(
                            isReturn: true,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: 'search'.tr(context),
                          onPressed: () {
                            navigateToResultFlight();
                          },
                          size: const Size(double.infinity, 50),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListView(
                      children: [
                        Text(
                          'flight_1'.tr(context),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BookFlightInherit(
                          fromText1,
                          toText1,
                          date1,
                          seatType1,
                          child: const BookFlightItem(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'flight_2'.tr(context),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BookFlightInherit(
                          fromText2,
                          toText2,
                          date2,
                          seatType2,
                          child: const BookFlightItem(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: 'search'.tr(context),
                          size: const Size(double.infinity, 50),
                        ),
                        const SizedBox(
                          height: 10,
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
    );
  }
}
