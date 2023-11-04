import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';
import '/constants/constants.dart';
import '../../animations/slide_animation.dart';
import '/localization/app_localization.dart';

import '../../cubits/bottom_bar/bottom_bar_cubit.dart';
import '/models/place/place_model.dart';
import '/utils/box_hive.dart';

import '/widgets/widgets.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late Box<PlaceModel> boxPlace;
  late BottomBarCubit bottomBarCubit;
  @override
  void initState() {
    super.initState();
    boxPlace = BoxHive.boxPlaces();
    bottomBarCubit = BlocProvider.of<BottomBarCubit>(context);
    bottomBarCubit.setPositionPage(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 150,
          backgroundColor: scafoldColorLight,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: const SlideAnimation(
              child: Image(
                image: AssetImage('assets/images/rectangleOval.png'),
                fit: BoxFit.fill,
              ),
            ),
            centerTitle: true,
            title: SlideAnimation(
                offsetX: false,
              child: Text(
                'favourite'.tr(context),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ValueListenableBuilder(
            valueListenable: boxPlace.listenable(),
            builder: (context, value, child) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: GridView.builder(
                  key: GlobalKey(debugLabel: 'Favourite'),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: boxPlace.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: PlaceItem(
                        screen: 'Favourite',
                        placeModel: value.values.toList()[index],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        )
      ],
    ));
  }
}
