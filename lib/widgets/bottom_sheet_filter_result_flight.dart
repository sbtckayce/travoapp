import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/widgets/type_range_slider.dart';

import '../config/app_router_name.dart';
import '../constants/constants.dart';
import 'widgets.dart';

class BottomSheetFilterResultFlight extends StatefulWidget {
  const BottomSheetFilterResultFlight({super.key});

  @override
  State<BottomSheetFilterResultFlight> createState() =>
      _BottomSheetFilterResultFlightState();
}

class _BottomSheetFilterResultFlightState
    extends State<BottomSheetFilterResultFlight> {
  List<String> tranSitString = ['Direct', '1 Transit', '2+ Transits'];

  ValueNotifier<int> selectIndexTransit = ValueNotifier(0);

  ValueNotifier<RangeValues> rangePriceValues =
      ValueNotifier(const RangeValues(0, 1000));

  ValueNotifier<RangeValues> rangeHourValues =
      ValueNotifier(const RangeValues(0, 24));

  ValueNotifier<Object?> resultSortBy = ValueNotifier(null);

  ValueNotifier<List<String>?> resultCheckBox = ValueNotifier(null);

  navigateToSortBy() async {
    resultSortBy.value = await context.pushNamed(AppRouterName.sortBy);
    if (resultSortBy.value != null) {}
  }

  navigateToFacilities() async {
    resultCheckBox.value = await context.pushNamed(AppRouterName.facilities);
    if (resultCheckBox.value != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: scafoldColorLight),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 75,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Text(
              'Transit',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(tranSitString.length, (index) {
                  return ValueListenableBuilder(
                    valueListenable: selectIndexTransit,
                    builder: (context, value, child) {
                      return InkWell(
                          onTap: () {
                            selectIndexTransit.value = index;
                          },
                          child: TransitItem(
                              backgroundColor: selectIndexTransit.value == index
                                  ? orangeSpice
                                  : nostaglaPerfume,
                              text: tranSitString[index],
                              colorText: selectIndexTransit.value == index
                                  ? Theme.of(context).colorScheme.onBackground
                                  : primaryColor));
                    },
                  );
                })
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TypeRangeSlider(
              name: 'Transit Duration',
              rangeValues: rangeHourValues,
              min: 0,
              max: 24,
              unitInt: 'h',
            ),
            TypeRangeSlider(
              name: 'Budget',
              rangeValues: rangePriceValues,
              min: 0,
              max: 1000,
              unitInt: '\$',
            ),
            const SizedBox(
              height: 10,
            ),
            ValueListenableBuilder(
              valueListenable: resultCheckBox,
              builder: (context, value, child) {
                return BoxFilterFlight(
                  imageUrl: 'assets/images/faciliti.png',
                  text: 'Facilities',
                  onTap: navigateToFacilities,
                  child: Column(
                    children: [
                      Text(
                        resultCheckBox.value.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      )
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ValueListenableBuilder(
              valueListenable: resultSortBy,
              builder: (context, value, child) {
                return BoxFilterFlight(
                  imageUrl: 'assets/images/sortBy.png',
                  text: 'Sort By',
                  onTap: navigateToSortBy,
                  child: Column(
                    children: [
                      Text(
                        resultSortBy.value.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      )
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomButton(
              text: 'Apply',
              size: Size(double.infinity, 50),
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomButton(
              text: 'Reset',
              colorText: primaryColor,
              backgroundColor: nostaglaPerfume,
              size: Size(double.infinity, 50),
            )
          ],
        ),
      ),
    );
  }
}
