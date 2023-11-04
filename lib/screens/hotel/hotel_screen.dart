
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '/repositories/hotel/hotel_repository.dart';

import '/animations/slide_animation.dart';

import '/localization/app_localization.dart';

import '/config/app_router_name.dart';

import '/cubits/hotel/hotel_cubit.dart';

import '/widgets/widgets.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({super.key});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  ScrollController controller = ScrollController();
  late HotelCubit hotelCubit;
  late HotelRepository hotelRepository;
  int limit = 3;

  @override
  void initState() {
    super.initState();
    hotelRepository = HotelRepository();
    hotelCubit = HotelCubit(hotelRepository);

    hotelCubit.getAllHotel(limit);

    controller.addListener(scrollListener);
  }

  void scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      hotelCubit.getAllHotelMore(limit,context);
    }
  }

  navigateToFilter() {
    context.goNamed(AppRouterName.filter);
  }

  GlobalKey buttonInfoHotelKey = GlobalKey();
  LayerLink layerLink = LayerLink();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 30,
          child: Stack(
            children: [
              SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    const BackGroundHeader(),
                    Positioned.fill(
                      left: 20,
                      right: 20,
                      child: Row(
                        children: [
                          const CustomBackButton(),
                          const Spacer(),
                          SlideAnimation(
                            offsetX: false,
                            child: Text(
                              'hotel_name'.tr(context),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 30),
                            ),
                          ),
                          const Spacer(),
                          CustomFuncButton(
                              onPressed: navigateToFilter,
                              icon: const Icon(Icons.filter_list_outlined))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                top: 120,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<HotelCubit, HotelState>(
                    bloc: hotelCubit,
                    builder: (context, state) {
                      if (state is HotelLoading) {
                        return const CircleIndicator();
                      }
                      if (state is HotelListLoaded) {
                        return state.hotels.isNotEmpty
                            ? ListView.builder(
                                controller: controller,
                                itemCount: state.hotels.length,
                                itemBuilder: (context, index) {
                                  return HotelItem(
                                      hotelModel: state.hotels[index]);
                                },
                              )
                            : NoItem(
                                text: 'no_item_hotel'.tr(context),
                              );
                      } else {
                        return const TextError();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
