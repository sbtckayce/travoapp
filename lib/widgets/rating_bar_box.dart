import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '/constants/constants.dart';

class RatingBarBox extends StatelessWidget {
  const RatingBarBox(
      {super.key,
      required this.initRating,
      required this.onRatingUpdate,
      this.color = kiwiCrush,
      this.itemSize = 20});
  final double initRating;
  final Function(double) onRatingUpdate;
  final Color? color;
  final double? itemSize;
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initRating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: color,
      ),
      itemSize: itemSize!,
      onRatingUpdate: onRatingUpdate,
    );
  }
}
