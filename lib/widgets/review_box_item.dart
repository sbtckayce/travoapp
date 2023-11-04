import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '/config/app_router_name.dart';
import '/constants/constants.dart';
import '/cubits/review/review_cubit.dart';
import '/repositories/user/user_repository.dart';
import '/localization/app_localization.dart';

import '/cubits/user/user_cubit.dart';
import '/models/review/review_model.dart';

import '/widgets/widgets.dart';
import 'package:read_more_text/read_more_text.dart';

class ReviewBoxItem extends StatefulWidget {
  const ReviewBoxItem({super.key, required this.reviewModel,});
  final ReviewModel reviewModel;
  
  @override
  State<ReviewBoxItem> createState() => _ReviewBoxItemState();
}

class _ReviewBoxItemState extends State<ReviewBoxItem> {
  late UserCubit userCubit;
  late ReviewCubit reviewCubit;

  late UserRepository userRepository;
  @override
  void initState() {
    super.initState();
    userRepository = UserRepository();
    userCubit = UserCubit(userRepository);

    userCubit.getInfoUserWhereEmail(widget.reviewModel.userEmail);

    reviewCubit = BlocProvider.of<ReviewCubit>(context);
  }

  navigateToEditReview() {
    context.pushNamed(AppRouterName.editReviewHotel,
        extra: widget.reviewModel,
        pathParameters: {'hotelId': widget.reviewModel.hotelId});
  }

  onDeleteReview() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'do_review'.tr(context),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
          actions: [
            CustomButtonDialog(
              onSubmit:deleteCommentToReview,
            )
          ],
        );
      },
    );
  }

  deleteCommentToReview() {
    reviewCubit.deleteCommentToReview(widget.reviewModel,context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<UserCubit, UserState>(
            bloc: userCubit,
            builder: (context, state) {
              if (state is UserLoading) {
                return const CircleIndicator();
              }
              if (state is UserLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.isEmail
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: navigateToEditReview,
                                child: const Icon(
                                  Icons.edit_outlined,
                                  color: primaryColor,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: onDeleteReview,
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: redPinkColor,
                                ),
                              )
                            ],
                          )
                        : const SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              state.userModel.avatar,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.userModel.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                          ],
                        ),
                        RatingBarBox(
                          initRating: widget.reviewModel.rating,
                          onRatingUpdate: (p0) {},
                        )
                      ],
                    ),
                  ],
                );
              } else {
                return const TextError();
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ReadMoreText(
            widget.reviewModel.comment,
            numLines: 2,
            readMoreText: 'see_more'.tr(context),
            readLessText: 'see_less'.tr(context),
            readMoreIconColor: Theme.of(context).colorScheme.secondary,
            readMoreTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w400),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 10,
          ),
          widget.reviewModel.photos.isNotEmpty
              ? SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.reviewModel.photos.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: index == 0 ? 0 : 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CacheImage(
                            imageUrl: widget.reviewModel.photos[index],
                            width: 100,
                          ),
                        ),
                      );
                    },
                  ),
                )
              : NoItem(text: 'no_image_review'.tr(context))
        ],
      ),
    );
  }
}
