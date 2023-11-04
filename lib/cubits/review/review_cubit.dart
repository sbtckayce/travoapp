import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/review/review_model.dart';
import '/repositories/review/review_repository.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewRepository _reviewRepository;
  ReviewCubit(this._reviewRepository) : super(ReviewLoading());

  getAllReviewWhereHotelId(String hotelId) {
    emit(ReviewLoading());
    _reviewRepository.getAllReviewWhereHotelId(hotelId).listen((event) {
  
      double avgRating = _reviewRepository.caculateAvgRating(event);
      int length = event.length;
      emit(ReviewLoaded(list: event, avgRating: avgRating, length: length));
    });
  }

  addCommentToReview(
      ReviewModel reviewModel, List<String> imageFiles, BuildContext context) {
    _reviewRepository.addCommentToReview(reviewModel, imageFiles, context);
  }

  editCommentToReview(
      ReviewModel reviewModel, List<String> imageFiles, BuildContext context) {
    _reviewRepository.editCommentToReview(reviewModel, imageFiles, context);
  }
  deleteCommentToReview(  ReviewModel reviewModel, BuildContext context){
  
    _reviewRepository.deleteCommentToReview(reviewModel,context);
  }
}
