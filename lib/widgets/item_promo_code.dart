import 'package:flutter/material.dart';
import '/extensions/capital_upper.dart';
import '/models/promo/promo_model.dart';
import '/widgets/widgets.dart';

class ItemPromoCode extends StatelessWidget {
  const ItemPromoCode({super.key, required this.promoModel});
  final PromoModel promoModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 20,
            child: CacheImage(imageUrl: promoModel.image),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            promoModel.endow.capitalize(),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }
}
