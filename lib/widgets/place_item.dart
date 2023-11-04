import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '/localization/app_localization.dart';

import '/widgets/widgets.dart';
import '/utils/box_hive.dart';

import '/constants/constants.dart';
import '/cubits/place/place_cubit.dart';

import '../utils/show_message_util.dart';

import '../models/place/place_model.dart';

class PlaceItem extends StatefulWidget {
  const PlaceItem({super.key, required this.placeModel, required this.screen});
  final PlaceModel placeModel;
  final String screen;
  @override
  State<PlaceItem> createState() => _PlaceItemState();
}

class _PlaceItemState extends State<PlaceItem> {
  late Box<PlaceModel> boxPlace;
  late PlaceCubit placeCubit;
  final GlobalKey parallaxKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    placeCubit = BlocProvider.of<PlaceCubit>(context);
    placeCubit.getPlaceFavourite(
        name: widget.placeModel.name,
        isFavourite: isFavourite,
        context: context);

    boxPlace = BoxHive.boxPlaces();
  }

  late ValueNotifier<bool> isFavourite =
      ValueNotifier(widget.placeModel.isFavourite);

  onTapFavouriteIcon() {
    isFavourite.value = !isFavourite.value;
    placeCubit.setPlaceFavourite(
        name: widget.placeModel.name,
        isFavourite: isFavourite.value,
        context: context);
    final boxPlace = BoxHive.boxPlaces();
    if (widget.screen == 'Home') {
      if (isFavourite.value) {
        boxPlace.put(widget.placeModel.name, widget.placeModel);

        showMessages('add_place'.tr(context), ContentType.success, context);
      } else {
        boxPlace.delete(widget.placeModel.name);

        showMessages('remove_place'.tr(context), ContentType.success, context);
      }
    } else {
      boxPlace.delete(widget.placeModel.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Flow(
            delegate: ParallaxFlowDelegate(
              scrollable: Scrollable.of(context),
              listItemContext: context,
              backgroundImageKey: parallaxKey,
            ),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CacheImage(
                  key: parallaxKey,
                  imageUrl: widget.placeModel.imageUrl,
                  height: 300,
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: isFavourite,
            builder: (context, value, child) {
              return Positioned(
                top: 5,
                right: 10,
                child: GestureDetector(
                    onTap: onTapFavouriteIcon,
                    child: widget.screen == 'Home'
                        ? isFavourite.value
                            ? const Icon(
                                Icons.favorite_rounded,
                                color: redPinkColor,
                              )
                            : Icon(
                                Icons.favorite_rounded,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              )
                        : Icon(
                            Icons.delete_rounded,
                            color: Theme.of(context).colorScheme.onBackground,
                          )),
              );
            },
          ),
          Positioned(
            left: 10,
            bottom: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.placeModel.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground,fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.star_outline,
                        color: kiwiCrush,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        widget.placeModel.rating.toString(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 12),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
