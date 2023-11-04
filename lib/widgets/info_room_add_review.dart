import 'package:flutter/material.dart';

import '../models/room/room_model.dart';
import 'widgets.dart';

class InfoRoomAddReview extends StatelessWidget {
  const InfoRoomAddReview({super.key, required this.roomModel});
  final RoomModel roomModel;
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
          Row(
            children: [
              Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8)
                          .copyWith(topLeft: const Radius.circular(40)),
                      child: CacheImage(imageUrl: roomModel.imageUrl))),
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            roomModel.name,
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
                            '\$${roomModel.price}',
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
          )
        ],
      ),
    );
  }
}
