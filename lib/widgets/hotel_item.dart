import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/app_router_name.dart';
import '/widgets/widgets.dart';
import '/constants/constants.dart';

import '/models/hotel/hotel_model.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';

class HotelItem extends StatefulWidget {
  const HotelItem({super.key, required this.hotelModel, this.isGrid = false});
  final HotelModel hotelModel;
  final bool? isGrid;
  @override
  State<HotelItem> createState() => _HotelItemState();
}

class _HotelItemState extends State<HotelItem> {
    final GlobalKey parallaxKey = GlobalKey();
  navigateToDetail() {
    context.goNamed(AppRouterName.detail, extra: widget.hotelModel);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.onBackground),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(20)),
                child: 
                CacheImage(imageUrl: widget.hotelModel.imageUrl)),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 25, horizontal: widget.isGrid == true ? 10 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.isGrid == true
                    ? Text(
                        widget.hotelModel.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )
                    : Text(
                        widget.hotelModel.name,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 20),
                      ),
                const SizedBox(
                  height: 10,
                ),
                widget.isGrid == true
                    ? GridViewLocationHotel(hotelModel: widget.hotelModel)
                    : ListViewLocationHotel(hotelModel: widget.hotelModel),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_outline,
                      color: kiwiCrush,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${widget.hotelModel.rating} ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w500),
                    ),
                    
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                DottedDashedLine(
                  height: 0,
                  width: double.infinity,
                  axis: Axis.horizontal,
                  dashColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                ),
                const SizedBox(
                  height: 15,
                ),
                widget.isGrid == true
                    ? GridViewPriceHotel(hotelModel: widget.hotelModel,onPressed: navigateToDetail,)
                    : ListViewPriceHotel(hotelModel: widget.hotelModel,onPressed: navigateToDetail,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
