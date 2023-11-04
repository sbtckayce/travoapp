part of 'review_cubit.dart';

 class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

final class ReviewLoading extends ReviewState {}
final class ReviewLoaded extends ReviewState {

  final List<ReviewModel> list;
  final double avgRating;
  final int length;

 const ReviewLoaded({required this.list,this.avgRating =0.0,this.length=0});
   @override
  List<Object> get props => [list,avgRating,length];
}
final class ReviewRating extends ReviewState {}