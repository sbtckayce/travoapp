import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/widgets/info_screen.dart';
import '/constants/constants.dart';
import '/utils/app_style.dart';

import '/utils/room_util.dart';
import '/localization/app_localization.dart';
import '/config/app_router_name.dart';
import '/models/room/room_model.dart';

import '/widgets/widgets.dart';

class RoomItem extends StatefulWidget {
  const RoomItem({
    super.key,
    required this.roomModel,
    required this.hotelId,
    this.isCheckout = false,
  });

  final RoomModel roomModel;
  final String hotelId;
  final bool? isCheckout;
  @override
  State<RoomItem> createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  navigateToCheckout() {
    context.pushNamed(AppRouterName.checkoutHotel,
        extra: widget.roomModel,
        pathParameters: {
          'roomId': widget.roomModel.id,
          'hotelId': widget.hotelId
        });
  }

  navigateToAddReview() {
    context.pushNamed(AppRouterName.addReviewHotel,
        extra: widget.roomModel,
        pathParameters: {
          'roomId': widget.roomModel.id,
          'hotelId': widget.hotelId
        });
  }

  GlobalKey buttonInfoRoomItemKey = GlobalKey();
  LayerLink layerLink = LayerLink();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.roomModel.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 22,
                                overflow: TextOverflow.ellipsis,
                                
                              ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.roomModel.typePrice,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w400),
                          ),
                          InfoScreen(
                              color: primaryColor,
                              buttonKey: buttonInfoRoomItemKey,
                              layerLink: layerLink,
                              width: 120,
                              widget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${'max_guest'.tr(context)} : ${widget.roomModel.maxGuest}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                  ),
                                  Text(
                                    '${'quantity'.tr(context)} : ${widget.roomModel.total}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CacheImage(
                  imageUrl: widget.roomModel.imageUrl,
                  width: 100,
                  height: 80,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
              children: List.generate(
            widget.roomModel.services.length,
            (index) => RoomUtil().getService(widget.roomModel.services[index]),
          )),
          const SizedBox(
            height: 10,
          ),
          const DottedDash(),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${widget.roomModel.price}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 24)),
                  Text('/night'.tr(context),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w400))
                ],
              ),
              widget.isCheckout!
                  ? Text('one_room'.tr(context),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w400))
                  : CustomButton(
                      text: 'choose'.tr(context),
                      onPressed: navigateToCheckout,
                    )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          widget.isCheckout!
              ? const SizedBox()
              : Row(
                  children: [
                    Text(
                      'review_it'.tr(context),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    GestureDetector(
                        onTap: navigateToAddReview,
                        child: Text(
                          'review'.tr(context),
                          style: appstyle(12, primaryColor, FontWeight.w500),
                        ))
                  ],
                )
        ],
      ),
    );
  }
}
