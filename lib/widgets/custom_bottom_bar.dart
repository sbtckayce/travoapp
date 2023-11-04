import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/app_router_name.dart';
import '/constants/constants.dart';
import '/cubits/bottom_bar/bottom_bar_cubit.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int currentIndex = 0;
  onTap(int value) {
    String routerName = '';
    switch (value) {
      case 0:
        routerName = AppRouterName.home;
      case 1:
        routerName = AppRouterName.favourite;

      case 2:
        routerName = AppRouterName.booking;
      case 3:
        routerName = AppRouterName.user;
    }

    context.goNamed(routerName);
  }

  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarCubit, BottomBarState>(
      builder: (context, state) {
        return CurvedNavigationBar(
            key: bottomNavigationKey,
            height: 60,
            index: state.index,
            onTap: onTap,
            backgroundColor: nostaglaPerfume,
            color: Theme.of(context).colorScheme.onBackground,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 400),
            items: const [
              Icon(
                Icons.home_outlined,
                color: redPinkColor,
              ),
              Icon(Icons.favorite_outline, color: redPinkColor),
              Icon(Icons.sell_outlined, color: redPinkColor),
              Icon(Icons.person_2_outlined, color: redPinkColor),
            ]);
      },
    );
  }
}
