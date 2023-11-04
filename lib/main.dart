import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/repositories/flight/flight_repository.dart';
import '/constants/constants.dart';
import '/cubits/network/network_cubit.dart';
import 'utils/show_message_util.dart';
import '/widgets/widgets.dart';
import '/cubits/review/review_cubit.dart';
import '/repositories/review/review_repository.dart';
import '/repositories/user/user_repository.dart';
import '/cubits/booking/booking_cubit.dart';
import '/cubits/user/user_cubit.dart';
import '/cubits/hotel/hotel_cubit.dart';
import '/cubits/room/room_cubit.dart';
import '/repositories/hotel/hotel_repository.dart';
import '/cubits/place/place_cubit.dart';

import 'cubits/flight/flight_cubit.dart';
import 'cubits/promo/promo_cubit.dart';
import 'repositories/booking/booking_repository.dart';
import 'repositories/place/place_repository.dart';
import '/cubits/change_language/change_language_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/app_router.dart';
import 'config/app_theme.dart';
import 'cubits/bottom_bar/bottom_bar_cubit.dart';
import 'cubits/change_theme/change_theme_cubit.dart';
import 'cubits/forgot_password/forgot_password_cubit.dart';
import 'cubits/login/login_cubit.dart';
import 'cubits/signout/signout_cubit.dart';
import 'cubits/signup/signup_cubit.dart';
import 'localization/app_localization.dart';
import 'repositories/auth/auth_repository.dart';
import 'repositories/promo/promo_repository.dart';
import 'repositories/room/room_repository.dart';

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;
  final PlaceRepository _placeRepository;
  final HotelRepository _hotelRepository;
  final RoomRepository _roomRepository;
  final BookingRepository _bookingRepository;
  final UserRepository _userRepository;
  final ReviewRepository _reviewRepository;
  final FlightRepository _flightRepository;
  final PromoRepository _promoRepository;
  const MyApp(
      {super.key,
      required AuthRepository authRepository,
      required PlaceRepository placeRepository,
      required HotelRepository hotelRepository,
      required RoomRepository roomRepository,
      required BookingRepository bookingRepository,
      required UserRepository userRepository,
      required ReviewRepository reviewRepository,
      required FlightRepository flightRepository,
      required PromoRepository promoRepository})
      : _authRepository = authRepository,
        _placeRepository = placeRepository,
        _hotelRepository = hotelRepository,
        _roomRepository = roomRepository,
        _bookingRepository = bookingRepository,
        _userRepository = userRepository,
        _reviewRepository = reviewRepository,
        _flightRepository = flightRepository,
        _promoRepository = promoRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authRepository,
        ),
        RepositoryProvider.value(
          value: _placeRepository,
        ),
        RepositoryProvider.value(
          value: _hotelRepository,
        ),
        RepositoryProvider.value(
          value: _roomRepository,
        ),
        RepositoryProvider.value(
          value: _bookingRepository,
        ),
        RepositoryProvider.value(
          value: _userRepository,
        ),
        RepositoryProvider.value(
          value: _flightRepository,
        ),
        RepositoryProvider.value(
          value: _promoRepository,
        ),
        RepositoryProvider.value(value: _reviewRepository)
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignUpCubit(_authRepository),
          ),
          BlocProvider(
            create: (context) => LoginCubit(_authRepository),
          ),
          BlocProvider(
            create: (context) => ForgotPasswordCubit(_authRepository),
          ),
          BlocProvider(
            create: (context) => SignOutCubit(_authRepository),
          ),
          BlocProvider(
            create: (context) => ChangeThemeCubit(),
          ),
          BlocProvider(
            create: (context) => ChangeLanguageCubit(),
          ),
          BlocProvider(
            create: (context) => PlaceCubit(_placeRepository),
          ),
          BlocProvider(
            create: (context) => HotelCubit(_hotelRepository),
          ),
          BlocProvider(
            create: (context) => RoomCubit(_roomRepository),
          ),
          BlocProvider(
            create: (context) => UserCubit(_userRepository),
          ),
          BlocProvider(
            create: (context) => BookingCubit(_bookingRepository),
          ),
          BlocProvider(
            create: (context) => ReviewCubit(_reviewRepository),
          ),
          BlocProvider(
            create: (context) => PromoCubit(_promoRepository),
          ),
          BlocProvider(
            create: (context) => FlightCubit(_flightRepository),
          ),
          BlocProvider(
            create: (context) => NetworkCubit()..checkConnection(),
          ),
          BlocProvider(create: (context) => BottomBarCubit())
        ],
        child: Builder(builder: (context) {
          return BlocConsumer<NetworkCubit, NetworkState>(
            listener: (context, state) {
              if (state is OffNetwork) {
            showMessages('No internet', ContentType.warning, context);
              }
            },
            builder: (context, stateNetwork) {
              if (stateNetwork is OffNetwork) {
                return MaterialApp(
                  title: 'TravoAppAC',
                  debugShowCheckedModeBanner: false,
                  home: Scaffold(
                    body: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(width: 1, color: primaryColor)),
                          child: Text(
                            stateNetwork.message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: redPinkColor, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (stateNetwork is OnNetwork) {
                return BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
                    builder: (context, stateChangeLanguage) {
                  return BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
                      builder: (context, stateChangeTheme) {
                    return MaterialApp.router(
                      title: 'TravoAppAC',
                      debugShowCheckedModeBanner: false,
                      locale: stateChangeLanguage.locale,
                      supportedLocales: const [Locale('en'), Locale('vi')],
                      theme:
                          stateChangeTheme.value ? themeDark() : themeLight(),
                      routerConfig: router,
                      localizationsDelegates: const [
                        AppLocalization.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate
                      ],
                    );
                  });
                });
              } else {
                return const TextError();
              }
            },
          );
        }),
      ),
    );
  }
}
