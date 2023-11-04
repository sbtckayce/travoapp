import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/promo/promo_model.dart';
import '/repositories/promo/promo_repository.dart';

part 'promo_state.dart';

class PromoCubit extends Cubit<PromoState> {
  final PromoRepository _promoRepository;

  PromoCubit(this._promoRepository) : super(PromoLoading());

  createPromo({required PromoModel promoModel, required BuildContext context}) {
    _promoRepository.createPromo(promoModel: promoModel, context: context);
  }

  getPromo(String code) {
    emit(PromoLoading());
    _promoRepository.getPromo(code).then((event) {
      emit(PromoLoaded(promoModel: event));
    });
  }

  deletePromo({required String name, required BuildContext context}) {
    _promoRepository.deletePromo(name: name, context: context);
  }
}
