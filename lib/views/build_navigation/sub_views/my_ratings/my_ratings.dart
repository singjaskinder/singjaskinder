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
        bottom: 40,
        top: 200,
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
      gradient: AppStyles.lightGradient,
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
          controller.userName,
          size: 2.4,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
        Visibility(
          visible: !controller.isEmpty.value,
          child: BuildText(
            'Total Ratings: ',
            size: 2.8,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
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
                      controller.isEmpty.value = false;
                      return ListView.separated(
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
                          });
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
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [AppStyles.tileShadow]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rating.driver.image == null
              ? CircleAvatar(
                  radius: SizeConfig.imageSizeMultiplier * 8,
                  backgroundColor: AppColors.violet.withOpacity(0.4),
                  child: Icon(
                    Feather.user,
                    color: AppColors.violet,
                    size: SizeConfig.imageSizeMultiplier * 5,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  child: CachedNetworkImage(
                    imageUrl: makeImageLink(rating.driver.image),
                    width: SizeConfig.imageSizeMultiplier * 16,
                    height: SizeConfig.imageSizeMultiplier * 16,
                    fit: BoxFit.cover,
                  ),
                ),
          BuildSizedBox(width: 3),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BuildText(
                rating.driver.name ?? '',
                color: AppColors.medViolet,
                fontWeight: FontWeight.bold,
                size: 3.2,
              ),
              Row(
                children: [
                  for (int i = 0; i < getRating(true); i++)
                    Icon(
                      Icons.star,
                      color: AppColors.yellow,
                      size: SizeConfig.imageSizeMultiplier * 5,
                    ),
                  getRating(false) == 0
                      ? BuildSizedBox()
                      : Icon(
                          Icons.star_half,
                          color: AppColors.yellow,
                          size: SizeConfig.imageSizeMultiplier * 5,
                        ),
                ],
              ),
              BuildText(
                rating.review,
                color: AppColors.medViolet,
                size: 2.25,
              ),
              BuildSizedBox(),
              BuildText(
                makeDateTime(rating.createdAt),
                color: AppColors.medViolet,
                size: 1.8,
              ),
            ],
          )),
        ],
      ),
    );
  }
}
