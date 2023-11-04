import 'package:flutter/material.dart';
import '/models/place/place_model.dart';

import '../constants/constants.dart';

class PlaceItemBookFlight extends StatelessWidget {
  const PlaceItemBookFlight(
      {super.key, required this.placeModel, this.onPressed});
  final PlaceModel placeModel;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(backgroundColor: nostaglaPerfume),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            placeModel.name,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500),
          ),
          Text(
            '${placeModel.rating}',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          )
        ],
      ),
    );
  }
}
