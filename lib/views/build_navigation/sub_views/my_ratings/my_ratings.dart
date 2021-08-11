import 'package:cached_network_image/cached_network_image.dart';
import 'package:dlivrDriver/common/build_circular_loading.dart';
import 'package:dlivrDriver/common/retry.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/user_image.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/models/api_response/rating_m.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:dlivrDriver/views/build_navigation/build_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'my_ratings_controller.dart';

class MyRatings extends StatelessWidget {
  const MyRatings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyRatingsController());
    return BuildViewWithBackground(
      hasBackButton: true,
      haveSafeArea: false,
      positionedImage: Positioned(
        bottom: 80,
        top: 150,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: 0.8,
            child: Image.asset(
              getImage('bg_main0.png'),
            ),
          ),
        ),
      ),
      gradient: AppStyles.darkGradient,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        BuildSizedBox(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: BuildText(
            'My Ratings',
            size: 3.5,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        BuildUserImage(
          imageData: controller.imageUrl,
        ),
        BuildText(
          controller.userName.capitalize,
          size: 2.4,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
        BuildSizedBox(
          height: 2,
        ),
        Expanded(
          child: GetBuilder<MyRatingsController>(
            builder: (controller) {
              return FutureBuilder<List<Ratings>>(
                  future: controller.getRatings(),
                  builder: (_, snap) {
                    if (snap.hasData) {
                      if (snap.data.isEmpty) {
                        controller.isEmpty.value = true;
                        return Center(
                            child: BuildText('No Ratings given yet',
                                color: AppColors.white,
                                fontFamily: AppStyles.robotoB));
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(8),
                              width: SizeConfig.widthMultiplier * 90,
                              decoration: BoxDecoration(
                                  color: AppColors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: AppColors.yellow,
                                      ),
                                      BuildSizedBox(),
                                      BuildText(
                                        controller.rating.value
                                            .toStringAsFixed(1),
                                        color: AppColors.lightViolet,
                                        fontWeight: FontWeight.bold,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.thumb_up,
                                        color: AppColors.yellow,
                                      ),
                                      BuildSizedBox(),
                                      BuildText(
                                        controller.getThumbs(true),
                                        color: AppColors.lightViolet,
                                        fontWeight: FontWeight.bold,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.thumb_down,
                                        color: AppColors.yellow,
                                      ),
                                      BuildSizedBox(),
                                      BuildText(
                                        controller.getThumbs(false),
                                        color: AppColors.lightViolet,
                                        fontWeight: FontWeight.bold,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          BuildSizedBox(
                            height: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: BuildText(
                              'Badges:',
                              size: 2.5,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GetBuilder<MyRatingsController>(
                            builder: (_) {
                              return Container(
                                height: SizeConfig.heightMultiplier * 17,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.badges.length,
                                    itemBuilder: (_, i) {
                                      final badge = controller.badges[i];
                                      return BuildBadge(badge, true,
                                          isSelected: true, onTap: () => null);
                                    }),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: BuildText(
                              'Reviews:',
                              size: 2.5,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: SizeConfig.heightMultiplier * 16,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: snap.data.length,
                                separatorBuilder: (_, i) {
                                  return SizedBox(
                                    height: SizeConfig.heightMultiplier,
                                  );
                                },
                                itemBuilder: (_, i) {
                                  final rating = snap.data[i];
                                  return BuildRatingTile(
                                    rating,
                                  );
                                }),
                          ),
                        ],
                      );
                    } else if (snap.hasError) {
                      print(snap.error);
                      return Center(
                          child:
                              BuildRetry(onRetry: () => controller.update()));
                    } else {
                      return BuildCircularLoading();
                    }
                  });
            },
          ),
        )
      ]),
    );
  }
}

class BuildRatingTile extends StatelessWidget {
  const BuildRatingTile(this.rating, {Key key}) : super(key: key);
  final Ratings rating;

  int getRating(bool beforePoint) {
    final ratings = rating.rating.toString().split('.');
    if (beforePoint) {
      return int.parse(ratings[0]);
    } else {
      return int.parse(ratings[1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.widthMultiplier * 60,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [AppStyles.tileShadow]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BuildText(rating.review, color: AppColors.medViolet, size: 3),
          BuildSizedBox(),
          BuildText(
            makeDateTime(rating.createdAt),
            color: AppColors.medViolet,
            size: 1.4,
          ),
        ],
      ),
    );
  }
}

class BuildBadge extends StatelessWidget {
  const BuildBadge(this.badge, this.isDriver,
      {this.isSelected, this.onTap, Key key})
      : super(key: key);
  final Function onTap;
  final bool isSelected;
  final bool isDriver;
  final BadgesM badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Stack(children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Opacity(
              opacity: isSelected ? 1 : 0.6,
              child: Container(
                decoration: BoxDecoration(),
                child: Image.asset(
                  badge.path,
                  width: SizeConfig.imageSizeMultiplier * 20,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          !isDriver
              ? SizedBox()
              : Positioned(
                  right: 0,
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.black.withOpacity(0.5)),
                      child: BuildText(
                        badge.count.toString(),
                        size: 1.6,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ))),
        ]),
        Container(
          child: BuildText(
            badge.label,
            textAlign: TextAlign.center,
            size: 1.8,
          ),
        ),
      ]),
    );
  }
}
