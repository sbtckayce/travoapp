import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/models/flight/flight_model.dart';
import '/models/info_flight/info_flight.dart';
import '/models/search_flight/search_flight.dart';
import '/models/review/review_model.dart';
import '/screens/edit_review_hotel/edit_review_hotel_screen.dart';
import '/utils/custom_transition_router_util.dart';
import '/screens/add_review_hotel/add_review_hotel_screen.dart';
import '/screens/review_hotel/review_hotel_screen.dart';
import '/screens/checkout_flight/checkout_flight_screen.dart';
import '../screens/add_card_flight/add_card_flight_screen.dart';
import '../screens/contact_flight/contact_flight_screen.dart';
import '../screens/promo_flight/promo_flight_screen.dart';
import '/screens/book_flight/book_flight_screen.dart';

import '/screens/result_flight/result_flight_screen.dart';
import '/screens/select_seat/select_seat_screen.dart';

import '../screens/promo_hotel/promo_hotel_screen.dart';
import '../screens/add_card_hotel/add_card_hotel_screen.dart';
import '/models/hotel/hotel_model.dart';
import '/models/room/room_model.dart';
import '../screens/checkout_hotel/checkout_hotel_screen.dart';
import '../screens/contact_hotel/contact_hotel_screen.dart';
import '/screens/detail/detail_screen.dart';
import '/screens/filter/filter_screen.dart';
import '/screens/room/room_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/sign_up_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/on_boarding/on_boarding_screen.dart';
import '../screens/splash/splash_screen.dart';
import '/screens/dashboard/dashboard_screen.dart';
import '/screens/favourite/favourite_screen.dart';
import '/screens/hotel/hotel_screen.dart';
import '../screens/booking/booking_screen.dart';
import '/screens/user/user_screen.dart';

import 'app_router_name.dart';
import '../repositories/auth/auth_repository.dart';

final GlobalKey<NavigatorState> _rootNavigation = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigation =
    GlobalKey(debugLabel: 'shell');

GoRouter router = GoRouter(
    navigatorKey: _rootNavigation,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: AppRouterName.splash,
        builder: (context, state) => const SplashScreen(),
        routes: [
          GoRoute(
            path: 'on_boarding',
            name: AppRouterName.onBoarding,
            builder: (context, state) => const OnBoardingScreen(),
          ),
          GoRoute(
              path: 'auth',
              name: AppRouterName.auth,
              builder: (context, state) => const LoginScreen(),
              routes: [
                GoRoute(
                  path: 'signup',
                  name: AppRouterName.signup,
                  builder: (context, state) => const SignUpScreen(),
                ),
                GoRoute(
                  path: 'forgot_password',
                  name: AppRouterName.forgotPassword,
                  builder: (context, state) => const ForgotPasswordScreen(),
                )
              ]),
        ],
        redirect: (context, state) {
          final bool loginPath = state.matchedLocation == '/auth';

          final bool onBoardingPath = state.matchedLocation == '/on_boarding';

          if (AuthRepository().user?.email == null && !loginPath) {
            return null;
          }
          if (AuthRepository().user?.email == null && onBoardingPath) {
            return '/on_boarding';
          }
          if (AuthRepository().user?.email != null) {
            return '/home';
          }

          return null;
        },
      ),
      ShellRoute(
        navigatorKey: _shellNavigation,
        builder: (context, state, child) {
          return DashBoardScreen(
            key: state.pageKey,
            widget: child,
          );
        },
        routes: [
          GoRoute(
              path: '/home',
              name: AppRouterName.home,
              builder: (context, state) => const HomeScreen(),
              pageBuilder: (context, state) =>
                  CustomTransitionRouterUtil().customTransition(
                    context: context,
                    state: state,
                    child: const HomeScreen(),
                  ),
              routes: [
                GoRoute(
                    path: 'book_flight',
                    name: AppRouterName.bookFlight,
                    parentNavigatorKey: _rootNavigation,
                    builder: (context, state) => const BookFlight(),
                    pageBuilder: (context, state) =>
                        CustomTransitionRouterUtil().customTransition(
                          context: context,
                          state: state,
                          child: const BookFlight(),
                        ),
                    routes: [
                      GoRoute(
                          path: 'result_flight',
                          name: AppRouterName.resultFlight,
                          parentNavigatorKey: _rootNavigation,
                          builder: (context, state) => state.extra != null
                              ? ResultFlightScreen(
                                  searchFlightModel:
                                      state.extra as SearchFlightModel)
                              : const HomeScreen(),
                          pageBuilder: (context, state) =>
                              CustomTransitionRouterUtil().customTransition(
                                context: context,
                                state: state,
                                child: state.extra != null
                                    ? ResultFlightScreen(
                                        searchFlightModel:
                                            state.extra as SearchFlightModel)
                                    : const HomeScreen(),
                              ),
                          routes: [
                            GoRoute(
                                path: 'select_seat',
                                name: AppRouterName.selectSeat,
                                parentNavigatorKey: _rootNavigation,
                                builder: (context, state) => state.extra != null
                                    ? SelectSeatScreen(
                                        flightModel: state.extra as FlightModel)
                                    : const HomeScreen(),
                                pageBuilder: (context, state) =>
                                    CustomTransitionRouterUtil()
                                        .customTransition(
                                      context: context,
                                      state: state,
                                      child: state.extra != null
                                          ? SelectSeatScreen(
                                              flightModel:
                                                  state.extra as FlightModel)
                                          : const HomeScreen(),
                                    ),
                                routes: [
                                  GoRoute(
                                      path: 'checkout_flight',
                                      name: AppRouterName.checkoutFlight,
                                      parentNavigatorKey: _rootNavigation,
                                      builder: (context, state) =>
                                          state.extra != null
                                              ? CheckoutFlightScreen(
                                                  infoFlightModel: state.extra
                                                      as InfoFlightModel)
                                              : const HomeScreen(),
                                      pageBuilder: (context, state) =>
                                          CustomTransitionRouterUtil()
                                              .customTransition(
                                            context: context,
                                            state: state,
                                            child: state.extra != null
                                                ? CheckoutFlightScreen(
                                                    infoFlightModel: state.extra
                                                        as InfoFlightModel)
                                                : const HomeScreen(),
                                          ),
                                      routes: [
                                        GoRoute(
                                          path: 'contact_flight',
                                          name: AppRouterName.contactFlight,
                                          parentNavigatorKey: _rootNavigation,
                                          builder: (context, state) =>
                                              const ContactFlightScreen(),
                                        ),
                                        GoRoute(
                                          path: 'promo_flight',
                                          name: AppRouterName.promoFlight,
                                          parentNavigatorKey: _rootNavigation,
                                          builder: (context, state) =>
                                              const PromoFlightScreen(),
                                        ),
                                        GoRoute(
                                          path: 'add_card_flight',
                                          name: AppRouterName.addCardFlight,
                                          parentNavigatorKey: _rootNavigation,
                                          builder: (context, state) =>
                                              const AddCardFlightScreen(),
                                        ),
                                      ])
                                ])
                          ])
                    ]),
                GoRoute(
                    path: 'hotel',
                    name: AppRouterName.hotel,
                    parentNavigatorKey: _rootNavigation,
                    builder: (context, state) => const HotelScreen(),
                    pageBuilder: (context, state) =>
                        CustomTransitionRouterUtil().customTransition(
                          context: context,
                          state: state,
                          child: const HotelScreen(),
                        ),
                    routes: [
                      GoRoute(
                          path: 'detail',
                          name: AppRouterName.detail,
                          parentNavigatorKey: _rootNavigation,
                          builder: (context, state) => state.extra != null
                              ? DetailScreen(
                                  hotelModel: state.extra as HotelModel)
                              : const HomeScreen(),
                          pageBuilder: (context, state) =>
                              CustomTransitionRouterUtil().customTransition(
                                context: context,
                                state: state,
                                child: state.extra != null
                                    ? DetailScreen(
                                        hotelModel: state.extra as HotelModel)
                                    : const HomeScreen(),
                              ),
                          routes: [
                            GoRoute(
                                path: 'review_hotel/:hotelId',
                                name: AppRouterName.reviewHotel,
                                parentNavigatorKey: _rootNavigation,
                                builder: (context, state) => ReviewHotelScreen(
                                    hotelId:
                                        state.pathParameters['hotelId'] ?? ''),
                                pageBuilder: (context, state) =>
                                    CustomTransitionRouterUtil()
                                        .customTransition(
                                      context: context,
                                      state: state,
                                      child: ReviewHotelScreen(
                                          hotelId:
                                              state.pathParameters['hotelId'] ??
                                                  ''),
                                    ),
                                routes: [
                                  GoRoute(
                                    path: 'edit_review_hotel',
                                    name: AppRouterName.editReviewHotel,
                                    parentNavigatorKey: _rootNavigation,
                                    builder: (context, state) => state.extra !=
                                            null
                                        ? EditReviewHotelScreen(
                                            hotelId: state.pathParameters[
                                                    'hotelId'] ??
                                                '',
                                            reviewModel:
                                                state.extra as ReviewModel)
                                        : const HomeScreen(),
                                    pageBuilder: (context, state) =>
                                        CustomTransitionRouterUtil()
                                            .customTransition(
                                                context: context,
                                                state: state,
                                                child: state.extra != null
                                                    ? EditReviewHotelScreen(
                                                        hotelId: state
                                                                    .pathParameters[
                                                                'hotelId'] ??
                                                            '',
                                                        reviewModel: state.extra
                                                            as ReviewModel)
                                                    : const HomeScreen()),
                                  )
                                ]),
                            GoRoute(
                                path: 'room/:hotelId',
                                name: AppRouterName.room,
                                parentNavigatorKey: _rootNavigation,
                                builder: (context, state) {
                                  return RoomScreen(
                                      hotelId:
                                          state.pathParameters['hotelId'] ??
                                              '');
                                },
                                pageBuilder: (context, state) =>
                                    CustomTransitionRouterUtil()
                                        .customTransition(
                                      context: context,
                                      state: state,
                                      child: state.extra != null
                                          ? RoomScreen(
                                              hotelId: state.pathParameters[
                                                      'hotelId'] ??
                                                  '')
                                          : const HomeScreen(),
                                    ),
                                routes: [
                                  GoRoute(
                                    path: 'add_review_hotel/:roomId',
                                    name: AppRouterName.addReviewHotel,
                                    parentNavigatorKey: _rootNavigation,
                                    builder: (context, state) =>
                                        AddReviewHotelScreen(
                                      roomId:
                                          state.pathParameters['roomId'] ?? '',
                                      hotelId:
                                          state.pathParameters['hotelId'] ?? '',
                                      roomModel: state.extra as RoomModel,
                                    ),
                                    pageBuilder: (context, state) =>
                                        CustomTransitionRouterUtil()
                                            .customTransition(
                                                context: context,
                                                state: state,
                                                child: state.extra != null
                                                    ? AddReviewHotelScreen(
                                                        roomId:
                                                            state.pathParameters[
                                                                    'roomId'] ??
                                                                '',
                                                        hotelId:
                                                            state.pathParameters[
                                                                    'hotelId'] ??
                                                                '',
                                                        roomModel: state.extra
                                                            as RoomModel,
                                                      )
                                                    : const HomeScreen()),
                                  ),
                                  GoRoute(
                                      path: 'checkout_hotel/:roomId',
                                      name: AppRouterName.checkoutHotel,
                                      parentNavigatorKey: _rootNavigation,
                                      builder: (context, state) =>
                                          state.extra != null
                                              ? CheckoutHotelScreen(
                                                  roomId: state.pathParameters[
                                                          'roomId'] ??
                                                      '',
                                                  hotelId: state.pathParameters[
                                                          'hotelId'] ??
                                                      '',
                                                  roomModel:
                                                      state.extra as RoomModel,
                                                )
                                              : const HomeScreen(),
                                      pageBuilder: (context, state) =>
                                          CustomTransitionRouterUtil()
                                              .customTransition(
                                            context: context,
                                            state: state,
                                            child: state.extra != null
                                                ? CheckoutHotelScreen(
                                                    roomId:
                                                        state.pathParameters[
                                                                'roomId'] ??
                                                            '',
                                                    hotelId:
                                                        state.pathParameters[
                                                                'hotelId'] ??
                                                            '',
                                                    roomModel: state.extra
                                                        as RoomModel,
                                                  )
                                                : const HomeScreen(),
                                          ),
                                      routes: [
                                        GoRoute(
                                          path: 'contact_hotel',
                                          name: AppRouterName.contactHotel,
                                          parentNavigatorKey: _rootNavigation,
                                          builder: (context, state) =>
                                              state.extra != null
                                                  ? ContactHotelScreen(
                                                      hotelId:
                                                          state.pathParameters[
                                                                  'hotelId'] ??
                                                              '',
                                                      roomId:
                                                          state.pathParameters[
                                                                  'roomId'] ??
                                                              '',
                                                      roomModel: state.extra
                                                          as RoomModel,
                                                    )
                                                  : const HomeScreen(),
                                          pageBuilder: (context, state) =>
                                              CustomTransitionRouterUtil()
                                                  .customTransition(
                                            context: context,
                                            state: state,
                                            child: state.extra != null
                                                ? ContactHotelScreen(
                                                    hotelId:
                                                        state.pathParameters[
                                                                'hotelId'] ??
                                                            '',
                                                    roomId:
                                                        state.pathParameters[
                                                                'roomId'] ??
                                                            '',
                                                    roomModel: state.extra
                                                        as RoomModel,
                                                  )
                                                : const HomeScreen(),
                                          ),
                                        ),
                                        GoRoute(
                                          path: 'promo_hotel',
                                          name: AppRouterName.promoHotel,
                                          parentNavigatorKey: _rootNavigation,
                                          builder: (context, state) =>
                                              state.extra != null
                                                  ? PromoHotelScreen(
                                                      hotelId:
                                                          state.pathParameters[
                                                                  'hotelId'] ??
                                                              '',
                                                      roomId:
                                                          state.pathParameters[
                                                                  'roomId'] ??
                                                              '',
                                                      roomModel: state.extra
                                                          as RoomModel,
                                                    )
                                                  : const HomeScreen(),
                                          pageBuilder: (context, state) =>
                                              CustomTransitionRouterUtil()
                                                  .customTransition(
                                            context: context,
                                            state: state,
                                            child: state.extra != null
                                                ? PromoHotelScreen(
                                                    hotelId:
                                                        state.pathParameters[
                                                                'hotelId'] ??
                                                            '',
                                                    roomId:
                                                        state.pathParameters[
                                                                'roomId'] ??
                                                            '',
                                                    roomModel: state.extra
                                                        as RoomModel,
                                                  )
                                                : const HomeScreen(),
                                          ),
                                        ),
                                        GoRoute(
                                          path: 'add_card_hotel',
                                          name: AppRouterName.addCardHotel,
                                          parentNavigatorKey: _rootNavigation,
                                          builder: (context, state) =>
                                              state.extra != null
                                                  ? AddCardHotelScreen(
                                                      hotelId:
                                                          state.pathParameters[
                                                                  'hotelId'] ??
                                                              '',
                                                      roomId:
                                                          state.pathParameters[
                                                                  'roomId'] ??
                                                              '',
                                                      roomModel: state.extra
                                                          as RoomModel,
                                                    )
                                                  : const HomeScreen(),
                                          pageBuilder: (context, state) =>
                                              CustomTransitionRouterUtil()
                                                  .customTransition(
                                            context: context,
                                            state: state,
                                            child: state.extra != null
                                                ? AddCardHotelScreen(
                                                    hotelId:
                                                        state.pathParameters[
                                                                'hotelId'] ??
                                                            '',
                                                    roomId:
                                                        state.pathParameters[
                                                                'roomId'] ??
                                                            '',
                                                    roomModel: state.extra
                                                        as RoomModel,
                                                  )
                                                : const HomeScreen(),
                                          ),
                                        )
                                      ])
                                ]),
                          ]),
                      GoRoute(
                        path: 'filter',
                        name: AppRouterName.filter,
                        parentNavigatorKey: _rootNavigation,
                        builder: (context, state) => const FilterScreen(),
                        pageBuilder: (context, state) =>
                            CustomTransitionRouterUtil().customTransition(
                          context: context,
                          state: state,
                          child: const FilterScreen(),
                        ),
                      ),
                    ]),
              ]),
          GoRoute(
            path: '/favourite',
            name: AppRouterName.favourite,
            builder: (context, state) => const FavouriteScreen(),
            pageBuilder: (context, state) =>
                CustomTransitionRouterUtil().customTransition(
              context: context,
              state: state,
              child: const FavouriteScreen(),
            ),
          ),
          GoRoute(
            path: '/booking',
            name: AppRouterName.booking,
            builder: (context, state) => const BookingScreen(),
            pageBuilder: (context, state) =>
                CustomTransitionRouterUtil().customTransition(
              context: context,
              state: state,
              child: const BookingScreen(),
            ),
          ),
          GoRoute(
            path: '/user',
            name: AppRouterName.user,
            builder: (context, state) => const UserScreen(),
            pageBuilder: (context, state) =>
                CustomTransitionRouterUtil().customTransition(
              context: context,
              state: state,
              child: const UserScreen(),
            ),
          )
        ],
      )
    ],
    refreshListenable: GoRouterRefreshStream(AuthRepository().authStateChange));

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
