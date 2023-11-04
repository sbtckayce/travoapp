import 'package:flutter/material.dart';
import '/models/room/room_model.dart';
import 'widgets.dart';

class ConfirmInfoRoom extends StatelessWidget {
  const ConfirmInfoRoom({super.key, required this.roomModel});
  final RoomModel roomModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomModel.name,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 24),
                ),
                Text(
                  roomModel.typePrice,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CacheImage(
                imageUrl: roomModel.imageUrl,
                width: 100,
                height: 60,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Image.asset(
              'assets/images/bed.png',
              width: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '${roomModel.total} King Bed',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}
