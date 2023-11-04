import 'package:flutter/material.dart';
import '../models/category/category_model.dart';


class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.5,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: categoryModel.backgroundColor,
            ),
            child: Image.asset(
              categoryModel.imageUrl,
              scale: 4,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          categoryModel.name,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).colorScheme.secondary),
        )
      ],
    );
  }
}
