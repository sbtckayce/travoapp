import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import '../models/hotel/hotel_model.dart';
import 'widgets.dart';

class ListViewPriceHotel extends StatelessWidget {
  const ListViewPriceHotel(
      {super.key, required this.hotelModel, this.onPressed});
  final HotelModel hotelModel;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$${hotelModel.price}',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 20),
              ),
              Text('/night'.tr(context),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w400))
            ],
          ),
        ),
        CustomButton(onPressed: onPressed, text: 'book_a_room'.tr(context))
      ],
    );
  }
}
