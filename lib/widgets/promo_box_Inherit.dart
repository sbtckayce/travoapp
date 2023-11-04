

import 'package:flutter/material.dart';

import '../models/promo/promo_model.dart';

class PromoBoxInherit extends InheritedWidget {
  const PromoBoxInherit(this.resultPromo, {super.key, required super.child});

  final PromoModel? resultPromo;

  static PromoBoxInherit of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PromoBoxInherit>()!;
  }

  @override
  bool updateShouldNotify(PromoBoxInherit oldWidget) {
    return true;
  }
}
