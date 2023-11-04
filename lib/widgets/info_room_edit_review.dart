import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubits/room/room_cubit.dart';


import 'widgets.dart';

class InfoRoomEditReview extends StatefulWidget {
  const InfoRoomEditReview({super.key, required this.roomId});
  final String roomId;

  @override
  State<InfoRoomEditReview> createState() => _InfoRoomEditReviewState();
}

class _InfoRoomEditReviewState extends State<InfoRoomEditReview> {
  late RoomCubit roomCubit;
  @override
  void initState() {
    roomCubit = BlocProvider.of<RoomCubit>(context);
    roomCubit.getRoomWhereRoomId(widget.roomId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20)
          .copyWith(top: 0, left: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12)
              .copyWith(topLeft: const Radius.circular(50)),
          color: Theme.of(context).colorScheme.onBackground),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<RoomCubit, RoomState>(
            builder: (context, state) {
             if(state is RoomLoading){
              return const CircleIndicator();
             }
             if(state is RoomLoaded){
               return Row(
                children: [
                  Expanded(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8)
                              .copyWith(topLeft: const Radius.circular(40)),
                          child:
                              CacheImage(imageUrl: state.room.imageUrl))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      alignment: Alignment.bottomRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Room',
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                state.room.name,
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
                              Text(
                                '\$${state.room.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
             }else{
              return const TextError();
             }
            },
          )
        ],
      ),
    );
  }
}
