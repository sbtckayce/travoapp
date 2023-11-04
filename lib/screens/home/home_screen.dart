import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '/repositories/booking/booking_repository.dart';
import '../../utils/show_message_util.dart';
import '/utils/app_style.dart';
import '/widgets/info_screen.dart';
import '../../constants/constants.dart';
import '../../cubits/bottom_bar/bottom_bar_cubit.dart';
import '/cubits/place/place_cubit.dart';
import '../../widgets/widgets.dart';
import '/localization/app_localization.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BottomBarCubit bottomBarCubit;
  late PlaceCubit placeCubit;
  late BookingRepository bookingRepository;
  final searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    placeCubit = BlocProvider.of<PlaceCubit>(context);
    placeCubit.getAllPlaceWhereName('');

    bottomBarCubit = BlocProvider.of<BottomBarCubit>(context);
    bottomBarCubit.setPositionPage(0);

    bookingRepository = BookingRepository();
    bookingRepository.getFirebaseMessagingToken();
  }

  searchPlaceWhereName() {
    placeCubit.getAllPlaceWhereName(searchController.text);
  }

  closeSearch() {
    searchController.text = '';

    placeCubit.getAllPlaceWhereName('');
  }

  GlobalKey buttonInfoHomeKey = GlobalKey();
  LayerLink layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 180,
              child: Stack(
                children: [
                  Stack(
                    children: [
                      const BackGroundHeader(),
                      Positioned(
                          top: 20,
                          left: 20,
                          child: InfoScreen(
                              color: Theme.of(context).colorScheme.onBackground,
                              buttonKey: buttonInfoHomeKey,
                              layerLink: layerLink,
                              width: 250,
                              widget: Text(
                                'info_app'.tr(context),
                                style: appstyle(
                                    15, primaryColor, FontWeight.normal),
                              ))),
                      const Positioned(
                          right: 0, top: 10, child: SwitchButtonChangeTheme()),
                      const InfoUserHome()
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SearchBox(
                      hintText: 'search_text_place'.tr(context),
                      vertical: 0,
                      horizontal: 20,
                      searchController: searchController,
                      suffixIcon: GestureDetector(
                        onTap: closeSearch,
                        child: const Icon(
                          Icons.close_outlined,
                          color: primaryColor,
                        ),
                      ),
                      onTap: searchPlaceWhereName,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const GridViewCategory(),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<PlaceCubit, PlaceState>(
                      builder: (context, state) {
                        if (state is PlaceLoading) {
                          return const CircleIndicator();
                        }
                        if (state is PlaceLoaded) {
                          return state.places.isNotEmpty
                              ? Expanded(
                                  child: RefreshIndicator(
                                  onRefresh: () {
                                    return Future.delayed(
                                      const Duration(seconds: 1),
                                      () {
                                        showMessages('refresh'.tr(context),
                                            ContentType.success, context);
                                        placeCubit.getAllPlaceWhereName('');
                                      },
                                    );
                                  },
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 25,
                                    ),
                                    itemCount: state.places.length,
                                    itemBuilder: (context, index) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: PlaceItem(
                                          screen: 'Home',
                                          placeModel: state.places[index],
                                        ),
                                      );
                                    },
                                  ),
                                ))
                              : NoItem(text: 'no_item_place'.tr(context));
                        } else {
                          return const TextError();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
