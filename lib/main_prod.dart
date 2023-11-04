import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';

import 'package:hive_flutter/adapters.dart';
import '/repositories/promo/promo_repository.dart';
import '/repositories/flight/flight_repository.dart';
import '/config_flavor.dart';

import 'main.dart';
import 'models/place/place_model.dart';
import 'repositories/auth/auth_repository.dart';
import 'repositories/booking/booking_repository.dart';
import 'repositories/hotel/hotel_repository.dart';
import 'repositories/place/place_repository.dart';
import 'repositories/review/review_repository.dart';
import 'repositories/room/room_repository.dart';
import 'repositories/user/user_repository.dart';
import 'utils/variable_const.dart';

Future<void> main() async {
  ConfigFlavor(values: FlavorValueProd());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Firebase.initializeApp();
  await FlutterNotificationChannel.registerNotificationChannel(
    description: 'Notification Message',
    id: 'travoapps',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'travoapps',
  );
  await Hive.initFlutter();

  Hive.registerAdapter(PlaceModelAdapter());

  await Hive.openBox<PlaceModel>(VariableConst.boxPlace);

  final authRepository = AuthRepository();
  final placeRepository = PlaceRepository();
  final hotelRepository = HotelRepository();
  final roomRepository = RoomRepository();
  final bookingRepository = BookingRepository();
  final userRepository = UserRepository();
  final reviewRepository = ReviewRepository();
  final flightRepository = FlightRepository();
  final promoRepository = PromoRepository();
  runApp(MyApp(
    authRepository: authRepository,
    placeRepository: placeRepository,
    hotelRepository: hotelRepository,
    roomRepository: roomRepository,
    bookingRepository: bookingRepository,
    userRepository: userRepository,
    reviewRepository: reviewRepository,
    flightRepository: flightRepository,
    promoRepository: promoRepository,
  ));
}
