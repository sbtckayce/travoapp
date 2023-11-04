
import 'package:flutter/material.dart';
import '/models/review/review_model.dart';

abstract class BaseReviewRepository {
  Stream<List<ReviewModel>> getAllReviewWhereHotelId(String hotelId);

  Future<void> addCommentToReview(ReviewModel reviewModel,List<String> imageFiles,BuildContext context);

   Future<void> editCommentToReview(ReviewModel reviewModel,List<String> imageFiles,BuildContext context);
   Future<void> deleteCommentToReview(ReviewModel reviewModel, BuildContext context);
}
