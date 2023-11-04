import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constants.dart';
import '../cubits/hotel/hotel_cubit.dart';
import 'widgets.dart';

class InfoHotelAddReview extends StatefulWidget {
  const InfoHotelAddReview({super.key, required this.hotelId});
  final String hotelId;
  @override
  State<InfoHotelAddReview> createState() => _InfoHotelAddReviewState();
}

class _InfoHotelAddReviewState extends State<InfoHotelAddReview> {
    late HotelCubit hotelCubit;
 

  @override
  void initState() {
    super.initState();
    hotelCubit = BlocProvider.of<HotelCubit>(context);
    hotelCubit.getAllHotelWhereHotelId(widget.hotelId);
   
  }

  @override
  Widget build(BuildContext context) {
    return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 20)
                            .copyWith(right: 0, bottom: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12)
                            .copyWith(bottomRight: const Radius.circular(50)),
                        color: Theme.of(context).colorScheme.onBackground),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<HotelCubit, HotelState>(
                          builder: (context, state) {
                            if (state is HotelLoading) {
                              return const CircleIndicator();
                            }
                            if (state is HotelLoaded) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Hotel',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    fontSize: 24,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.hotel.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary),
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
                                                  Expanded(
                                                    child: Text(
                                                      state.hotel.location,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8)
                                        .copyWith(
                                            bottomRight:
                                                const Radius.circular(40)),
                                    child: CacheImage(
                                        imageUrl: state.hotel.imageUrl),
                                  ))
                                ],
                              );
                            } else {
                              return const TextError();
                            }
                          },
                        )
                      ],
                    ),
                  );
  }
}