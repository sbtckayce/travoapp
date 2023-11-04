import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/localization/app_localization.dart';
import '/utils/variable_const.dart';

import '../cubits/user/user_cubit.dart';
import 'widgets.dart';

class InfoUserHome extends StatefulWidget {
  const InfoUserHome({super.key});

  @override
  State<InfoUserHome> createState() => _InfoUserHomeState();
}

class _InfoUserHomeState extends State<InfoUserHome> {
  late UserCubit userCubit;
  @override
  void initState() {
    super.initState();
    userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.getInfoUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const CircleIndicator();
        }
        if (state is UserLoaded) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${'hi'.tr(context)} ${state.userModel.name}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'go_next'.tr(context),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                   state.userModel.avatar.isNotEmpty ?   Container(
                        margin: const EdgeInsets.only(left: 15),
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onBackground,
                            border: Border.all(
                                width: 1,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                            borderRadius: BorderRadius.circular(12)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: state.userModel.avatar.isNotEmpty
                              ? CacheImage(imageUrl: state.userModel.avatar)
                              : CacheImage(imageUrl: VariableConst.noImageUrl),
                        ),
                      ) : CacheImage(imageUrl: VariableConst.noImageUrl)
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return const TextError();
        }
      },
    );
  }
}
