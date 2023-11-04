import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '/repositories/hotel/hotel_repository.dart';

import '../../utils/show_message_util.dart';
import '/constants/constants.dart';

import '/localization/app_localization.dart';

import '../../widgets/type_range_slider.dart';
import '../../cubits/hotel/hotel_cubit.dart';
import '/widgets/widgets.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late HotelCubit hotelCubit;
  late HotelRepository hotelRepository;

  ValueNotifier<RangeValues> rangePriceValues =
      ValueNotifier(const RangeValues(0, 1000));

  ValueNotifier<RangeValues> rangeRatingValues =
      ValueNotifier(const RangeValues(0, 5));
  ValueNotifier<bool> isDesc = ValueNotifier(false);

  ValueNotifier<bool> isGrid = ValueNotifier(false);

  int limit = 10;

  ScrollController controller = ScrollController();

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    hotelRepository = HotelRepository();
    hotelCubit = HotelCubit(hotelRepository);

    hotelCubit.getAllHotelWhereName('');
  }

  showFilterPrice() async {
    await showDialog(
      context: context,
      builder: (context) {
        return DialogFilter(
          typeRangeSilder: TypeRangeSlider(
            name: 'price_range'.tr(context),
            rangeValues: rangePriceValues,
            min: 0,
            max: 1000,
            isDouble: true,
            unitDouble: '\$',
          ),
          onPressed: () {
            hotelCubit.getAllHotelWherePrice(
              rangePriceValues.value.start.toInt(),
              rangePriceValues.value.end.toInt(),
            );
            context.pop();
          },
        );
      },
    );
  }

  showFilterRating() async {
    await showDialog(
      context: context,
      builder: (context) {
        return DialogFilter(
          typeRangeSilder: TypeRangeSlider(
            name: 'rating_range'.tr(context),
            rangeValues: rangeRatingValues,
            min: 0,
            max: 5,
            unitInt: 'star',
          ),
          onPressed: () {
            hotelCubit.getAllHotelWhereRating(
                rangeRatingValues.value.start.toDouble(),
                rangeRatingValues.value.end.toDouble());
            context.pop();
          },
        );
      },
    );
  }

  sortHotelAZ() {
    isDesc.value = !isDesc.value;
    hotelCubit.getAllHotelAZ(isDesc.value);
  }

  searchHotelWhereName() {
    hotelCubit.getAllHotelWhereName(searchController.text);
  }

  closeSearch() {
    searchController.text = '';

    hotelCubit.getAllHotelWhereName('');
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: CustomHeader(title: 'filter_name'.tr(context))),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchBox(
                          searchController: searchController,
                          onTap: searchHotelWhereName,
                          horizontal: 0,
                          vertical: 10,
                          suffixIcon: GestureDetector(
                            onTap: closeSearch,
                            child: const Icon(
                              Icons.close_outlined,
                              color: primaryColor,
                            ),
                          ),
                          hintText: 'search_text_hotel'.tr(context)),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TypeFilter(
                              icon: const Icon(Icons.euro_outlined),
                              name: 'price'.tr(context),
                              onTap: showFilterPrice,
                            ),
                            TypeFilter(
                              icon: const Icon(Icons.star_rate_outlined),
                              name: 'rating'.tr(context),
                              onTap: showFilterRating,
                            ),
                            ValueListenableBuilder(
                              valueListenable: isDesc,
                              builder: (context, value, child) {
                                return TypeFilter(
                                  icon: isDesc.value
                                      ? const RotatedBox(
                                          quarterTurns: 2,
                                          child: Icon(Icons.sort_outlined))
                                      : const Icon(Icons.sort_outlined),
                                  name: 'sort'.tr(context),
                                  onTap: sortHotelAZ,
                                );
                              },
                            ),
                            ValueListenableBuilder(
                              valueListenable: isGrid,
                              builder: (context, value, child) {
                                return TypeFilter(
                                  icon: isGrid.value
                                      ? const Icon(Icons.grid_view_outlined)
                                      : const Icon(Icons.list_outlined),
                                  name: 'view'.tr(context),
                                  onTap: () {
                                    isGrid.value = !isGrid.value;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 7,
                        child: BlocBuilder<HotelCubit, HotelState>(
                          bloc: hotelCubit,
                          builder: (context, state) {
                            if (state is HotelLoading) {
                              return const CircleIndicator();
                            }
                            if (state is HotelListLoaded) {
                              return state.hotels.isNotEmpty
                                  ? ValueListenableBuilder(
                                      valueListenable: isGrid,
                                      builder: (context, value, child) {
                                        return RefreshIndicator(
                                            onRefresh: () {
                                              return Future.delayed(
                                                const Duration(seconds: 1),
                                                () {
                                                  showMessages(
                                                      'refresh'.tr(context),
                                                      ContentType.success,
                                                      context);
                                                  hotelCubit.getAllHotel(limit);
                                                },
                                              );
                                            },
                                            child: isGrid.value
                                                ? GridView.builder(
                                                    itemCount:
                                                        state.hotels.length,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                            childAspectRatio:
                                                                0.4,
                                                            crossAxisSpacing:
                                                                10,
                                                            mainAxisSpacing:
                                                                10),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return HotelItem(
                                                          isGrid: true,
                                                          hotelModel: state
                                                              .hotels[index]);
                                                    },
                                                  )
                                                : ListView.builder(
                                                    itemCount:
                                                        state.hotels.length,
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return HotelItem(
                                                          hotelModel: state
                                                              .hotels[index]);
                                                    },
                                                  ));
                                      },
                                    )
                                  : NoItem(text: 'no_item_hotel'.tr(context));
                            } else {
                              return const TextError();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
