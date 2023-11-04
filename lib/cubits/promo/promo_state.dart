part of 'promo_cubit.dart';

class PromoState extends Equatable {
  const PromoState();

  @override
  List<Object> get props => [];
}

class PromoLoading extends PromoState{

}
class PromoLoaded extends PromoState{
  final PromoModel promoModel;
const  PromoLoaded({required this.promoModel});
  @override
  List<Object> get props => [promoModel];
}
