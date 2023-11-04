import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/repositories/review/review_repository.dart';
import '/animations/slide_animation.dart';

import '/localization/app_localization.dart';

import '/constants/constants.dart';
import '/cubits/review/review_cubit.dart';
import '/utils/app_style.dart';
import '/widgets/review_box_item.dart';

import '../../widgets/widgets.dart';

class ReviewHotelScreen extends StatefulWidget {
  const ReviewHotelScreen({super.key, required this.hotelId});
  final String hotelId;
  @override
  State<ReviewHotelScreen> createState() => _ReviewHotelScreenState();
}

class _ReviewHotelScreenState extends State<ReviewHotelScreen> {
  late ReviewCubit reviewCubit;

  @override
  void initState() {
    super.initState();
    reviewCubit = ReviewCubit(ReviewRepository());
    reviewCubit.getAllReviewWhereHotelId(widget.hotelId);
  }
 final GlobalKey<ScaffoldState> reviewScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: reviewScaffoldKey,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 30,
          child: Stack(
            children: [
              SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    const BackGroundHeader(),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: CustomBackButton(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 200,
                        child: SlideAnimation(
                          offsetX: false,
                          child: Text(
                            'review_hotel'.tr(context),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                top: 120,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocBuilder<ReviewCubit, ReviewState>(
                      bloc: reviewCubit,
                      builder: (context, state) {
                        if (state is ReviewLoading) {
                          return const CircleIndicator();
                        }
                        if (state is ReviewLoaded) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            state.avgRating.toStringAsFixed(1),
                                            style: appstyle(
                                                36, kiwiCrush, FontWeight.w500),
                                          ),
                                          Text(
                                            'of 5',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary),
                                          ),
                                          Text(
                                            '(${state.length} reviews)',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: 10,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary),
                                          )
                                        ],
                                      ),
                                      Image.asset(
                                        'assets/images/review.png',
                                        width: 192,
                                      )
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: state.list.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ReviewBoxItem(
                                        
                                        reviewModel: state.list[index]);
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const TextError();
                        }
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
