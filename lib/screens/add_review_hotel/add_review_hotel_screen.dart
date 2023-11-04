import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '/localization/app_localization.dart';
import '../../utils/show_message_util.dart';

import '/cubits/review/review_cubit.dart';
import '/models/review/review_model.dart';

import '../../constants/constants.dart';
import '../../models/room/room_model.dart';
import '../../widgets/widgets.dart';

class AddReviewHotelScreen extends StatefulWidget {
  const AddReviewHotelScreen(
      {super.key,
      required this.roomModel,
      required this.roomId,
      required this.hotelId});
  final RoomModel roomModel;
  final String roomId;
  final String hotelId;

  @override
  State<AddReviewHotelScreen> createState() => _AddReviewHotelScreenState();
}

class _AddReviewHotelScreenState extends State<AddReviewHotelScreen> {
  late ReviewCubit reviewCubit;

  @override
  void initState() {
    super.initState();

    reviewCubit = BlocProvider.of<ReviewCubit>(context);
  }

  final commentController = TextEditingController();
  ValueNotifier<double> ratingValue = ValueNotifier(4.0);
  ValueNotifier<List<String>> valueListImage = ValueNotifier([]);
  List<String> images = [];
  addCommentToReview() {
    if (commentController.text.isEmpty) {
    
          showMessages('pls_write_comment'.tr(context), ContentType.warning, context);
    }
    if (valueListImage.value.isEmpty) {
     
          showMessages('pls_choose_image'.tr(context), ContentType.warning, context);
    } else if (commentController.text.isNotEmpty &&
        valueListImage.value.isNotEmpty) {
      ReviewModel reviewModel = ReviewModel(
      
          hotelId: widget.hotelId,
          roomId: widget.roomId,
          userEmail: 'email',
          ratedTime: DateTime.now(),
          comment: commentController.text,
          photos: valueListImage.value,
          rating: ratingValue.value);
      reviewCubit.addCommentToReview(
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
            CustomHeader(title: 'add_review'.tr(context)),
            Expanded(
                child: SingleChildScrollView(
                    child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoHotelAddReview(hotelId: widget.hotelId),
                  const SizedBox(
                    height: 20,
                  ),
                  InfoRoomAddReview(roomModel: widget.roomModel),
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
                              initRating: 4,
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
                      return valueListImage.value.isNotEmpty
                          ? GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemCount: valueListImage.value.length,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      File(valueListImage.value[index]),
                                      fit: BoxFit.cover,
                                    ));
                              },
                            )
                          : const SizedBox();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: 'post'.tr(context),
                    size: const Size(double.infinity, 50),
                    onPressed: addCommentToReview,
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
