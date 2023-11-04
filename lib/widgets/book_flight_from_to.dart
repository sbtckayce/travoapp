import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import '/widgets/widgets.dart';

class BookFlightFromTo extends StatefulWidget {
  const BookFlightFromTo({
    super.key,
  });

  @override
  State<BookFlightFromTo> createState() => _BookFlightFromToState();
}

class _BookFlightFromToState extends State<BookFlightFromTo> {
  choosePlaceFrom(ValueNotifier<String> fromText) async {
    await showDialog(
      context: context,
      builder: (context) {
        return DialogFromToBookFlight(
          text: fromText,
        );
      },
    );
  }

  choosePlaceTo(ValueNotifier<String> toText) async {
    await showDialog(
      context: context,
      builder: (context) {
        return DialogFromToBookFlight(
          text: toText,
        );
      },
    );
  }

  swapText(ValueNotifier<String> fromText, ValueNotifier<String> toText) {
    String temp = fromText.value;
    fromText.value = toText.value;
    toText.value = temp;
  }

  @override
  Widget build(BuildContext context) {
    final fromText = BookFlightInherit.of(context).fromText;
    final toText = BookFlightInherit.of(context).toText;
    return Stack(
      children: [
        Column(
          children: [
            ValueListenableBuilder(
              valueListenable: fromText,
              builder: (context, value, child) {
                return BookFlightBoxItem(
                  icon: 'assets/images/plane.png',
                  title: 'from'.tr(context),
                  name: fromText.value,
                  onTap: () {
                    choosePlaceFrom(fromText);
                  },
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: toText,
              builder: (context, value, child) {
                return BookFlightBoxItem(
                  icon: 'assets/images/location.png',
                  title: 'to'.tr(context),
                  name: toText.value,
                  onTap: () {
                    choosePlaceTo(toText);
                  },
                );
              },
            ),
          ],
        ),
        Positioned(
            right: 60,
            top: 50,
            child: GestureDetector(
              onTap: () {
                swapText(fromText, toText);
              },
              child: const CircleAvatar(
                radius: 30,
                child: Icon(Icons.sync_outlined),
              ),
            )),
      ],
    );
  }
}
