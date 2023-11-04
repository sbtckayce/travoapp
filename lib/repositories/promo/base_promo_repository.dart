import 'package:flutter/material.dart';

import '/models/promo/promo_model.dart';

abstract class BasePromoRepository {
  Future<void> createPromo(
      {required PromoModel promoModel, required BuildContext context});
  Future<void> deletePromo(
      {required String name, required BuildContext context});
  Future<PromoModel> getPromo(String code);
}
