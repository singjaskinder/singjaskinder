import 'package:dlivrDriver/common/build_circular_loading.dart';
import 'package:dlivrDriver/common/job_tile.dart';
import 'package:dlivrDriver/common/retry.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/models/api_response/job_m.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_biddings_controller.dart';

class MyBiddings extends StatelessWidget {
  const MyBiddings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyBiddingsController());
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BuildSizedBox(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BuildText(
              'Bidded jobs',
              size: 3.5,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          BuildSizedBox(),
          Expanded(
            child: GetBuilder<MyBiddingsController>(
              builder: (controller) {
                return FutureBuilder<List<Jobs>>(
                    future: controller.getJobs(),
                    builder: (_, snap) {
                      if (snap.hasData) {
                        if (snap.data.isEmpty) {
                          return Center(
                              child: BuildText('No bidded jobs found',
                                  color: AppColors.white,
                                  fontFamily: AppStyles.robotoB));
                        }
                        return ListView.separated(
                            itemCount: snap.data.length,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            separatorBuilder: (_, i) {
                              return SizedBox(
                                height: SizeConfig.heightMultiplier,
                              );
                            },
                            itemBuilder: (_, i) {
                                final job = snap.data[i];
                              return BuildJobTile(
                                job,
                                onTap: () => controller.toBiddedJobDetails(job)
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
        ],
      ),
    );
  }
}
