import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/localization/app_localization.dart';
import '/animations/fade_animation.dart';

import '../config/app_router_name.dart';
import '../models/category/category_model.dart';
import 'category_item.dart';

class GridViewCategory extends StatefulWidget {
  const GridViewCategory({super.key});

  @override
  State<GridViewCategory> createState() => _GridViewCategoryState();
}

class _GridViewCategoryState extends State<GridViewCategory> {
  navigateToScreen(int index) {
    String routerName = '';
    switch (index) {
      case 0:
        routerName = AppRouterName.hotel;

      case 1:
        routerName = AppRouterName.bookFlight;

      case 2:
        routerName = AppRouterName.home;
    }
    context.goNamed(routerName);
  }

  late List<CategoryModel> categories = [
    CategoryModel(
        name: 'hotels'.tr(context),
        imageUrl: 'assets/images/hotel.png',
        backgroundColor: const Color(0xFFf1dadd)),
    CategoryModel(
        name: 'flights'.tr(context),
        imageUrl: 'assets/images/flight.png',
        backgroundColor: const Color(0xFFf1dadd)),
    CategoryModel(
        name: 'all'.tr(context),
        imageUrl: 'assets/images/group.png',
        backgroundColor: const Color(0xFFcceaeb))
  ];

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      child: SizedBox(
          height: 120,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 0.4, crossAxisSpacing: 15),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  navigateToScreen(index);
                },
                child: CategoryItem(categoryModel: categories[index]),
              );
            },
          )),
    );
  }
}
