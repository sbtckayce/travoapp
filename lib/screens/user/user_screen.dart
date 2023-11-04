import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../cubits/bottom_bar/bottom_bar_cubit.dart';
import '../../utils/show_message_util.dart';
import '/localization/app_localization.dart';
import '/cubits/user/user_cubit.dart';
import '/utils/variable_const.dart';
import '../../widgets/widgets.dart';
import '/constants/constants.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late BottomBarCubit bottomBarCubit;
  late UserCubit userCubit;
  @override
  void initState() {
    super.initState();
    userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.getInfoUser();
    bottomBarCubit = BlocProvider.of<BottomBarCubit>(context);
    bottomBarCubit.setPositionPage(3);
  }

  ValueNotifier<String> imageUrl = ValueNotifier('');
  Future<void> imageGallery() async {
    try {
      ImagePicker imagePiker = ImagePicker();
      XFile? imageFile =
          await imagePiker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        imageUrl.value = imageFile.path;
      }
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }

  Future<void> imageCamera() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? imageFile =
          await imagePicker.pickImage(source: ImageSource.camera);
      if (imageFile != null) {
        imageUrl.value = imageFile.path;
      }
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }

  showBottomSheetCamera() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 120,
          padding: const EdgeInsets.all(10),
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.onBackground),
          child: Column(
            children: [
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const CircleIndicator();
                  }
                  if (state is UserLoaded) {
                    return ButtonImageCamera(
                      imageUrl: imageUrl,
                      onPressed: () {
                        imageCamera().then((value) {
                          context.pop();
                          userCubit.updateAvatar(
                              state.userModel, File(imageUrl.value), context);
                        });
                      },
                    );
                  } else {
                    return const TextError();
                  }
                },
              ),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const CircleIndicator();
                  }
                  if (state is UserLoaded) {
                    return ButtonImageGallery(
                      imageUrl: imageUrl,
                      onPressed: () {
                        imageGallery().then((value) {
                          context.pop();
                          userCubit.updateAvatar(
                              state.userModel, File(imageUrl.value), context);
                        });
                      },
                    );
                  } else {
                    return const TextError();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  final GlobalKey<ScaffoldState> userScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: userScaffoldKey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(
              title: 'user_profile'.tr(context),
              isLeading: false,
            ),
            Expanded(
                child: SingleChildScrollView(
                  physics:const BouncingScrollPhysics(),
                    child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Center(
                    child: Container(
                        width: 160,
                        height: 160,
                        padding: const EdgeInsets.all(3),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            border: Border.all(
                                width: 2,
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                        child: Stack(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: imageUrl,
                              builder: (context, value, child) {
                                return BlocBuilder<UserCubit, UserState>(
                                  builder: (context, state) {
                                    if (state is UserLoading) {
                                      return const CircleIndicator();
                                    }
                                    if (state is UserLoaded) {
                                      return imageUrl.value.isNotEmpty
                                          ? CircleAvatar(
                                              radius: 80,
                                              backgroundImage: FileImage(
                                                  File(imageUrl.value)),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                              child: CacheImage(
                                                imageUrl: state.userModel.avatar
                                                        .isNotEmpty
                                                    ? state.userModel.avatar
                                                    : VariableConst.noImageUrl,
                                                height: 160,
                                                width: 160,
                                              ));
                                    } else {
                                      return const TextError();
                                    }
                                  },
                                );
                              },
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: showBottomSheetCamera,
                                child: const CircleAvatar(
                                  child: Icon(
                                    Icons.edit_rounded,
                                    color: primaryColor,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(width: 1, color: primaryColor),
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                            child: BlocBuilder<UserCubit, UserState>(
                              builder: (context, state) {
                                if (state is UserLoading) {
                                  return const CircleIndicator();
                                }
                                if (state is UserLoaded) {
                                  return Column(
                                    children: [
                                      Text(
                                        'info_user'.tr(context),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                      ),
                                      InfoUserItem(
                                        title: 'name'.tr(context),
                                        description: state.userModel.name,
                                      ),
                                      InfoUserItem(
                                        title: 'email'.tr(context),
                                        description: state.userModel.email,
                                      ),
                                      InfoUserItem(
                                        title: 'country'.tr(context),
                                        description: state.userModel.country,
                                      ),
                                      InfoUserItem(
                                        title: 'phone'.tr(context),
                                        description:
                                            state.userModel.phoneNumber,
                                      ),
                                    ],
                                  );
                                } else {
                                  return const TextError();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          UserBoxItem(
                              name: 'language'.tr(context),
                              child: const DropDownLanguage()),
                          const SizedBox(
                            height: 10,
                          ),
                          UserBoxItem(
                            name: 'sign_out'.tr(context),
                            child: const ButtonSignOut(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )))
          ],
        ),
      ),
    );
  }
}
