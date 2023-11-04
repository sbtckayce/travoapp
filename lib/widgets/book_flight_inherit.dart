import 'package:flutter/material.dart';
import '/screens/select_seat/select_seat_screen.dart';



class BookFlightInherit extends InheritedWidget {
  const BookFlightInherit(this.fromText, this.toText, this.date, this.seatType,   {super.key, required super.child});

  final ValueNotifier<String> fromText;
  final ValueNotifier<String> toText;
  final ValueNotifier<DateTime> date;
  final ValueNotifier<SeatType> seatType;

  static BookFlightInherit of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BookFlightInherit>()!;
  }

  @override
  bool updateShouldNotify(BookFlightInherit oldWidget) {
    return true;
  }
}
