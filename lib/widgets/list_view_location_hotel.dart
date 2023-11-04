import 'package:flutter/material.dart';
import '/models/hotel/hotel_model.dart';

import '../constants/constants.dart';

class ListViewLocationHotel extends StatelessWidget {
  const ListViewLocationHotel({super.key, required this.hotelModel});
  final HotelModel hotelModel;
  @override
  Widget build(BuildContext context) {
    return Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: redPinkColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${hotelModel.location} - ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                            child: Text(
                              hotelModel.locationDescription,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w300),
                            ),
                          )
                        ],
                      );
  }
}