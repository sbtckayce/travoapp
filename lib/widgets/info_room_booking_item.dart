import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/localization/app_localization.dart';
import '/cubits/room/room_cubit.dart';
import '/repositories/room/room_repository.dart';
import '/widgets/circle_indicator.dart';
import '/widgets/text_error.dart';

import 'cache_image.dart';

class InfoRoomBookingItem extends StatefulWidget {
  const InfoRoomBookingItem({super.key, required this.roomId});
  final String roomId;

  @override
  State<InfoRoomBookingItem> createState() => _InfoRoomBookingItemState();
}

class _InfoRoomBookingItemState extends State<InfoRoomBookingItem> {
  late RoomCubit roomCubit;
  late RoomRepository roomRepository;
  @override
  void initState() {
    super.initState();
    roomRepository = RoomRepository();
    roomCubit = RoomCubit(roomRepository);
    roomCubit.getRoomWhereRoomId(widget.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomState>(
      bloc: roomCubit,
      builder: (context, state) {
        if (state is RoomLoading) {
          return const CircleIndicator();
        }
        if (state is RoomLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'room'.tr(context),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CacheImage(
                        imageUrl: state.room.imageUrl,
                        width: 100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.room.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          '\$${state.room.price}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          state.room.typePrice,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ],
          );
        } else {
          return const TextError();
        }
      },
    );
  }
}
