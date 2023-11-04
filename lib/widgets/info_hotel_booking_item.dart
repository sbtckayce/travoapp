

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/localization/app_localization.dart';
import '/cubits/hotel/hotel_cubit.dart';
import '/repositories/hotel/hotel_repository.dart';

import '/widgets/circle_indicator.dart';
import '/widgets/text_error.dart';

import '../constants/constants.dart';
import 'cache_image.dart';

class InfoHotelBookingItem extends StatefulWidget {
  const InfoHotelBookingItem({super.key, required this.hotelId});

  final String hotelId;
  @override
  State<InfoHotelBookingItem> createState() => _InfoHotelBookingItemState();
}

class _InfoHotelBookingItemState extends State<InfoHotelBookingItem> {
  late HotelCubit hotelCubit;
  late HotelRepository hotelRepository;
  @override
  void initState() {
    super.initState();

    hotelRepository = HotelRepository();

    hotelCubit = HotelCubit(hotelRepository);

       
    hotelCubit.getAllHotelWhereHotelId(widget.hotelId);

    
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelCubit, HotelState>(
      bloc: hotelCubit,
      
      builder: (context, state) {
      if (state is HotelLoading) {
        return const CircleIndicator();
      }
      if (state is HotelLoaded) {
    
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Text(
              'hotel'.tr(context),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        state.hotel.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: redPinkColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              state.hotel.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.star_outline,
                            color: kiwiCrush,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              '${state.hotel.rating}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CacheImage(
                        imageUrl: state.hotel.imageUrl,
                        width: 150,
                        height: 100,
                      )),
                ),
              ],
            ),
          ],
        );
      } else {
        return const TextError();
      }
    });
  }
}
