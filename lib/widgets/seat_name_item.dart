import 'package:flutter/material.dart';
import '/constants/constants.dart';
import '/screens/select_seat/select_seat_screen.dart';

class SeatNameItem extends StatelessWidget {
  const SeatNameItem(
      {super.key,
      required this.name,
      this.onTap,
  
      required this.backGroundColor,
      required this.colorText,
      required this.seatType,
      required this.seatStatus});
    
  final String name;
  final Function()? onTap;
  final bool seatStatus;
  final Color backGroundColor;
  final Color colorText;

  final SeatType seatType;
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 30,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: seatStatus ? nostaglaPerfume : backGroundColor,
            border: seatStatus
                ? null
                : Border.all(
                    width: 1,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.3))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(name,
                style: seatStatus
                    ? Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.transparent)
                    : Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: colorText)),
          ],
        ),
      ),
    );
  }
}
