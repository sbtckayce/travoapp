import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import '../utils/show_message_util.dart';
import '/localization/app_localization.dart';

import '../screens/select_seat/select_seat_screen.dart';
import '/widgets/seat_name_item.dart';
import '/widgets/shape_select_seat_inherit.dart';

class ListGridViewSeatItem extends StatefulWidget {
  const ListGridViewSeatItem({
    Key? key,
    required this.seatType,
  }) : super(key: key);

  final SeatType seatType;

  @override
  State<ListGridViewSeatItem> createState() => _ListGridViewSeatItemState();
}

class _ListGridViewSeatItemState extends State<ListGridViewSeatItem> {
  ValueNotifier<int> indexInMap = ValueNotifier(0);
  ValueNotifier<int> indexInList = ValueNotifier(0);
  late Color colorBackgroundSeatBusiness =
      Theme.of(context).colorScheme.onBackground;
  late Color colorBackgroundSeatEconomy =
      Theme.of(context).colorScheme.onBackground;

  late Color colorTextSeatBusiness = Theme.of(context).colorScheme.secondary;
  late Color colorTextSeatEconomy = Theme.of(context).colorScheme.secondary;
  chooseBusinessSeat(
    List<List<bool>> valuesMapBusinessSeat,
    ValueNotifier<String> currentSeat,
    ValueNotifier<String> currentTypeSeat,
    int indexInValuesMapSeat,
    int indexInListSeat,
  ) {
    currentTypeSeat.value = 'Business';
    indexInMap.value = indexInValuesMapSeat;
    indexInList.value = indexInListSeat;
    //key + name
    switch (indexInValuesMapSeat) {
      case 0:
        currentSeat.value =
            "1${generateSeatNameBusiness(valuesMapBusinessSeat, 0, indexInListSeat)}";
      case 1:
        currentSeat.value =
            "2${generateSeatNameBusiness(valuesMapBusinessSeat, 1, indexInListSeat)}";
      case 2:
        currentSeat.value =
            "3${generateSeatNameBusiness(valuesMapBusinessSeat, 2, indexInListSeat)}";
    }
    if (currentTypeSeat.value == 'Business' &&
        indexInMap.value == indexInValuesMapSeat &&
        indexInList.value == indexInListSeat) {
      colorBackgroundSeatBusiness = Theme.of(context).colorScheme.secondary;
      colorBackgroundSeatEconomy = Theme.of(context).colorScheme.onBackground;

      colorTextSeatBusiness = Theme.of(context).colorScheme.onBackground;
      colorTextSeatEconomy = Theme.of(context).colorScheme.secondary;
    }
    log('index ${valuesMapBusinessSeat[indexInValuesMapSeat][indexInListSeat]}');
  }

  chooseEconomyClassSeat(
    List<List<bool>> valuesMapEconomyClassSeat,
    ValueNotifier<String> currentSeat,
    ValueNotifier<String> currentTypeSeat,
    int indexInValuesMapSeat,
    int indexInListSeat,
  ) {
    currentTypeSeat.value = 'EconomyClass';
    indexInMap.value = indexInValuesMapSeat;
    indexInList.value = indexInListSeat;
    //key + name
    switch (indexInValuesMapSeat) {
      case 0:
        currentSeat.value =
            "1${generateSeatNameEconomy(valuesMapEconomyClassSeat, 0, indexInListSeat)}";
      case 1:
        currentSeat.value =
            "2${generateSeatNameEconomy(valuesMapEconomyClassSeat, 1, indexInListSeat)}";
      case 2:
        currentSeat.value =
            "3${generateSeatNameEconomy(valuesMapEconomyClassSeat, 2, indexInListSeat)}";
      case 3:
        currentSeat.value =
            "4${generateSeatNameEconomy(valuesMapEconomyClassSeat, 3, indexInListSeat)}";
      case 4:
        currentSeat.value =
            "5${generateSeatNameEconomy(valuesMapEconomyClassSeat, 4, indexInListSeat)}";
    }
    if (currentTypeSeat.value == 'EconomyClass' &&
        indexInMap.value == indexInValuesMapSeat &&
        indexInList.value == indexInListSeat) {
      colorBackgroundSeatBusiness = Theme.of(context).colorScheme.onBackground;
      colorBackgroundSeatEconomy = Theme.of(context).colorScheme.secondary;

      colorTextSeatBusiness = Theme.of(context).colorScheme.secondary;
      colorTextSeatEconomy = Theme.of(context).colorScheme.onBackground;
    }
  }

  String generateSeatNameBusiness(List<List<bool>> valuesMapBusinessSeat,
      int indexInValuesMapSeat, int indexInListSeat) {
    String name = '';
    switch (indexInListSeat) {
      case 0:
        name = 'A';
      case 1:
        name = 'B';
      case 2:
        name = 'C';
      case 3:
        name = 'D';
    }

    return name;
  }

  String generateSeatNameEconomy(List<List<bool>> valuesMapEconomyClassSeat,
      int indexInValuesMapSeat, int indexInListSeat) {
    String name = '';
    switch (indexInListSeat) {
      case 0:
        name = 'A';
      case 1:
        name = 'B';
      case 2:
        name = 'C';
      case 3:
        name = 'D';
      case 4:
        name = 'E';
      case 5:
        name = 'F';
    }

    return name;
  }

  Color generateSeatTextColor(
      ValueNotifier<int> indexInMap,
      ValueNotifier<int> indexInList,
      ValueNotifier<String> currentTypeSeat,
      int indexInValuesMapSeat,
      int indexInListSeat) {
    if (currentTypeSeat.value == 'Business' &&
        indexInMap.value == indexInValuesMapSeat &&
        indexInList.value == indexInListSeat) {
      return colorTextSeatBusiness;
    } else if (currentTypeSeat.value == 'EconomyClass' &&
        indexInMap.value == indexInValuesMapSeat &&
        indexInList.value == indexInListSeat) {
      return colorTextSeatEconomy;
    } else {
      return Theme.of(context).colorScheme.secondary;
    }
  }

  Color generateSeatBackground(
      ValueNotifier<int> indexInMap,
      ValueNotifier<int> indexInList,
      ValueNotifier<String> currentTypeSeat,
      int indexInValuesMapSeat,
      int indexInListSeat) {
    if (currentTypeSeat.value == 'Business' &&
        indexInMap.value == indexInValuesMapSeat &&
        indexInList.value == indexInListSeat) {
      return colorBackgroundSeatBusiness;
    } else if (currentTypeSeat.value == 'EconomyClass' &&
        indexInMap.value == indexInValuesMapSeat &&
        indexInList.value == indexInListSeat) {
      return colorBackgroundSeatEconomy;
    } else {
      return Theme.of(context).colorScheme.onBackground;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mapBusinessSeat = ShapeSelectSeatInherit.of(context).mapBusinessSeat;

    final valuesMapBusinessSeat = mapBusinessSeat.values.toList();

    final mapEconomyClassSeat =
        ShapeSelectSeatInherit.of(context).mapEconomyClassSeat;

    final valuesMapEconomyClassSeat = mapEconomyClassSeat.values.toList();

    final currentSeat = ShapeSelectSeatInherit.of(context).currentSeat;

    final currentTypeSeat = ShapeSelectSeatInherit.of(context).currentTypeSeat;

    return SizedBox(
      width: widget.seatType == SeatType.business ? 180 : 220,
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.seatType == SeatType.business
            ? valuesMapBusinessSeat.length
            : valuesMapEconomyClassSeat.length,
        itemBuilder: (context, indexInValuesMapSeat) {
          return SizedBox(
            height: 50,
            width: 180,
            child: GridView.builder(
              itemCount: widget.seatType == SeatType.business
                  ? valuesMapBusinessSeat[indexInValuesMapSeat].length
                  : valuesMapEconomyClassSeat[indexInValuesMapSeat].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.seatType == SeatType.business ? 4 : 6,
                  childAspectRatio:
                      widget.seatType == SeatType.business ? 1 : 0.9),
              itemBuilder: (context, indexInListSeat) {
                final seatName = widget.seatType == SeatType.business
                    ? generateSeatNameBusiness(valuesMapBusinessSeat,
                        indexInValuesMapSeat, indexInListSeat)
                    : generateSeatNameEconomy(valuesMapEconomyClassSeat,
                        indexInValuesMapSeat, indexInListSeat);
                final seatStatus = widget.seatType == SeatType.business
                    ? valuesMapBusinessSeat[indexInValuesMapSeat]
                        [indexInListSeat]
                    : valuesMapEconomyClassSeat[indexInValuesMapSeat]
                        [indexInListSeat];

                return ValueListenableBuilder(
                  valueListenable: currentSeat,
                  builder: (context, value, child) {
                    return ValueListenableBuilder(
                      valueListenable: currentTypeSeat,
                      builder: (context, value, child) {
                        return ValueListenableBuilder(
                          valueListenable: indexInMap,
                          builder: (context, value, child) {
                            return ValueListenableBuilder(
                                valueListenable: indexInList,
                                builder: (context, value, child) {
                                  return SeatNameItem(
                                    onTap: () {
                                      if (seatStatus) {
                                        showMessages('require_seat'.tr(context),
                                            ContentType.warning, context);
                                      } else {
                                        widget.seatType == SeatType.business
                                            ? chooseBusinessSeat(
                                                valuesMapBusinessSeat,
                                                currentSeat,
                                                currentTypeSeat,
                                                indexInValuesMapSeat,
                                                indexInListSeat)
                                            : chooseEconomyClassSeat(
                                                valuesMapEconomyClassSeat,
                                                currentSeat,
                                                currentTypeSeat,
                                                indexInValuesMapSeat,
                                                indexInListSeat);
                                      }
                                    },
                                    seatType: widget.seatType,
                                    name: seatName,
                                    seatStatus: seatStatus,
                                    colorText: generateSeatTextColor(
                                        indexInMap,
                                        indexInList,
                                        currentTypeSeat,
                                        indexInValuesMapSeat,
                                        indexInListSeat),
                                    backGroundColor: generateSeatBackground(
                                        indexInMap,
                                        indexInList,
                                        currentTypeSeat,
                                        indexInValuesMapSeat,
                                        indexInListSeat),
                                  );
                                });
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
