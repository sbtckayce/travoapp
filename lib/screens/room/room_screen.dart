import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/repositories/room/room_repository.dart';

import '/animations/slide_animation.dart';
import '../../utils/show_message_util.dart';

import '/localization/app_localization.dart';

import '../../cubits/room/room_cubit.dart';

import '../../widgets/widgets.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({
    super.key,
    required this.hotelId,
  });

  final String hotelId;

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late RoomCubit roomCubit;
  late RoomRepository roomRepository;
  @override
  void initState() {
    super.initState();
    roomRepository = RoomRepository();
    roomCubit = RoomCubit(roomRepository);
    roomCubit.getAllRoomByHotel(widget.hotelId);
  }

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
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: CustomBackButton(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SlideAnimation(
                        offsetX: false,
                        child: Text(
                          'select_room'.tr(context),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                top: 120,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<RoomCubit, RoomState>(
                    bloc: roomCubit,
                    builder: (context, state) {
                      if (state is RoomLoading) {
                        return const CircleIndicator();
                      }
                      if (state is RoomListLoaded) {
                        return RefreshIndicator(
                          onRefresh: () {
                            return Future.delayed(
                              const Duration(seconds: 1),
                              () {
                                showMessages('refresh'.tr(context),
                                    ContentType.success, context);
                                roomCubit.getAllRoomByHotel(widget.hotelId);
                              },
                            );
                          },
                          child: state.rooms.isNotEmpty
                              ? Overlay(
                                  initialEntries: [
                                    OverlayEntry(
                                      builder: (context) {
                                        return ListView.builder(
                                          itemCount: state.rooms.length,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return RoomItem(
                                              hotelId: widget.hotelId,
                                              roomModel: state.rooms[index],
                                            );
                                          },
                                        );
                                      },
                                    )
                                  ],
                                )
                              : NoItem(text: 'no_item_room'.tr(context)),
                        );
                      } else {
                        return const TextError();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
