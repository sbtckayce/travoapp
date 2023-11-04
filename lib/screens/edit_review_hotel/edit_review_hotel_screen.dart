import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '/cubits/review/review_cubit.dart';
import '/localization/app_localization.dart';

import '../../constants/constants.dart';

import '../../models/review/review_model.dart';

import '../../utils/show_message_util.dart';
import '../../widgets/widgets.dart';

class EditReviewHotelScreen extends StatefulWidget {
  const EditReviewHotelScreen({
    super.key,
    required this.reviewModel,
    required this.hotelId,
  });
  final String hotelId;
  final ReviewModel reviewModel;
  @override
  State<EditReviewHotelScreen> createState() => _EditReviewHotelScreenState();
}

class _EditReviewHotelScreenState extends State<EditReviewHotelScreen> {
  late ReviewCubit reviewCubit;
  @override
  void initState() {
    super.initState();

    commentController.text = widget.reviewModel.comment;

    reviewCubit = BlocProvider.of<ReviewCubit>(context);
  }

  final commentController = TextEditingController();
  ValueNotifier<double> ratingValue = ValueNotifier(4.0);
  ValueNotifier<List<String>> valueListImage = ValueNotifier([]);

  List<String> images = [];

  editCommentToReview() {
    if (commentController.text.isEmpty) {
     
            showMessages('pls_write_comment'.tr(context), ContentType.warning, context);
    }
    if (valueListImage.value.isEmpty) {
        showMessages('pls_edit_image'.tr(context), ContentType.warning, context);
    } else if (commentController.text.isNotEmpty &&
        valueListImage.value.isNotEmpty) {
      ReviewModel reviewModel = ReviewModel(
          uid: widget.reviewModel.uid,
          hotelId: widget.reviewModel.hotelId,
          roomId: widget.reviewModel.roomId,
          userEmail: 'email',
          ratedTime: DateTime.now(),
          comment: commentController.text,
          photos: valueListImage.value,
          rating: ratingValue.value);
      reviewCubit.editCommentToReview(
          reviewModel, valueListImage.value, context);
    }
  }

  chooseImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();

    List<XFile>? imageFile = await imagePicker.pickMultiImage();
    if (imageFile.isNotEmpty) {
      for (var image in imageFile) {
        images.add(image.path);
      }
      valueListImage.value = List.from(images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: Column(
          children: [
            CustomHeader(title: 'edit_review'.tr(context)),
            Expanded(
                child: SingleChildScrollView(
                    child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoHotelAddReview(hotelId: widget.reviewModel.hotelId),
                  const SizedBox(
                    height: 20,
                  ),
                  InfoRoomEditReview(roomId: widget.reviewModel.roomId),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: ratingValue,
                        builder: (context, value, child) {
                          return RatingBarBox(
                              initRating: widget.reviewModel.rating,
                              onRatingUpdate: (rating) {
                                ratingValue.value = rating;
                              });
                        },
                      ),
                      ValueListenableBuilder(
                        valueListenable: valueListImage,
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: chooseImageFromGallery,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(width: 1, color: primaryColor),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                              padding: const EdgeInsets.all(10),
                              child: const Icon(Icons.camera_outlined,
                                  color: primaryColor),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1, color: primaryColor),
                        color: Theme.of(context).colorScheme.onBackground),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'comment'.tr(context),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        TextField(
                          controller: commentController,
                          minLines: 2,
                          maxLines: null,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                        ),
                      ],
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: valueListImage,
                    builder: (context, value, child) {
                      return GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: valueListImage.value.isNotEmpty
                            ? valueListImage.value.length
                            : widget.reviewModel.photos.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: valueListImage.value.isNotEmpty
                                  ? Image.file(
                                      File(valueListImage.value[index]),
                                      fit: BoxFit.cover,
                                    )
                                  : CacheImage(
                                      imageUrl:
                                          widget.reviewModel.photos[index],
                                    ));
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: 'edit'.tr(context),
                    size: const Size(double.infinity, 50),
                    onPressed: editCommentToReview,
                  )
                ],
              ),
            )))
          ],
        ),
      ),
    );
  }
}
