import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dlivrDriver/common/build_circular_loading.dart';
import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/job_title.dart';
import 'package:dlivrDriver/common/retry.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/text_field.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/models/api_response/job_m.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:dlivrDriver/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'home_controller.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return BuildViewWithBackground(
      hasBackButton: false,
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GetBuilder<HomeController>(
                builder: (controller) {
                  return FutureBuilder<List<Jobs>>(
                      future: controller.getJobs(),
                      builder: (_, snap) {
                        if (snap.hasData) {
                          if (snap.data.isEmpty) {
                            return Center(
                                child: BuildText('No nearby jobs found',
                                    color: AppColors.white,
                                    fontFamily: AppStyles.robotoB));
                          }
                          return ListView.separated(
                              itemCount: snap.data.length,
                              padding: EdgeInsets.zero,
                              separatorBuilder: (_, i) {
                                return SizedBox(
                                  height: SizeConfig.heightMultiplier,
                                );
                              },
                              itemBuilder: (_, i) {
                                final job = snap.data[i];
                                return BuildJobTile(job,
                                    onTap: () => controller.toJobDetails(job));
                              });
                        } else if (snap.hasError) {
                          print(snap.error);
                          return Center(
                              child: BuildRetry(
                                  onRetry: () => controller.update()));
                        } else {
                          return BuildCircularLoading();
                        }
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

