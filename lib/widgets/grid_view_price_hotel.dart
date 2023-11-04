import 'package:flutter/material.dart';
import '/localization/app_localization.dart';
import '/models/hotel/hotel_model.dart';
import '/widgets/widgets.dart';

class GridViewPriceHotel extends StatelessWidget {
  const GridViewPriceHotel({super.key, required this.hotelModel, this.onPressed});
  final HotelModel hotelModel;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '\$${hotelModel.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 20),
                              ),
                              Text('/night',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontWeight: FontWeight.w400))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              onPressed: onPressed,
                              text: 'book_a_room'.tr(context))
                        ],
                      );
  }
}