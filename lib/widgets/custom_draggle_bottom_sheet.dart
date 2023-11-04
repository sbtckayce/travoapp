import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/localization/app_localization.dart';
import '/config/app_router_name.dart';
import '/models/hotel/hotel_model.dart';

import '../constants/constants.dart';
import 'widgets.dart';

class CustomDraggleBottomSheet extends StatefulWidget {
  const CustomDraggleBottomSheet({super.key, required this.hotelModel});
  final HotelModel hotelModel;

  @override
  State<CustomDraggleBottomSheet> createState() =>
      _CustomDraggleBottomSheetState();
}

class _CustomDraggleBottomSheetState extends State<CustomDraggleBottomSheet> {
  navigateToRoom() {
    context.pushNamed(AppRouterName.room,
        extra: widget.hotelModel,
        pathParameters: {'hotelId': widget.hotelModel.uid});
  }

  navigateToReview() {
    context.pushNamed(AppRouterName.reviewHotel,
        pathParameters: {'hotelId': widget.hotelModel.uid});
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.1,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Theme.of(context).colorScheme.onBackground),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: ListView(
              controller: scrollController,
              children: [
                Center(
                  child: Container(
                    width: 75,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.hotelModel.name,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '\$${widget.hotelModel.price}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 24,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '/night'.tr(context),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: redPinkColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.hotelModel.location,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const DottedDash(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star_outline,
                          color: kiwiCrush,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${widget.hotelModel.rating}/5',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        
                      ],
                    ),
                    GestureDetector(
                        onTap: navigateToReview,
                        child: Text(
                          'see_all'.tr(context),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: primaryColor),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const DottedDash(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'information'.tr(context),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.hotelModel.information,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OptionService(
                        imageUrl: 'assets/images/restaurant.png',
                        name: 'Restaurant'),
                    OptionService(
                        imageUrl: 'assets/images/wifi.png', name: 'Wifi'),
                    OptionService(
                        imageUrl: 'assets/images/currency.png',
                        name: 'Currency Exchange'),
                    OptionService(
                        imageUrl: 'assets/images/24hour.png',
                        name: '24-hour Front Desk'),
                    OptionService(
                        imageUrl: 'assets/images/more.png', name: 'More')
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'location'.tr(context),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.hotelModel.locationDescription,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  text: 'select_room'.tr(context),
                  onPressed: navigateToRoom,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
