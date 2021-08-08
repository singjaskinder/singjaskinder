import 'package:cached_network_image/cached_network_image.dart';
import 'package:dlivrDriver/common/build_circular_loading.dart';
import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/job_title.dart';
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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'inprogress_job_details_controller.dart';

class InprogressJobDetails extends StatelessWidget {
  const InprogressJobDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InprogressJobDetailsController());
    return BuildViewWithBackground(
      hasBackButton: true,
      haveSafeArea: false,
      positionedImage: Positioned(
        bottom: 0,
        top: 300,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: 0.8,
            child: Image.asset(
              getImage('bg_main2.png'),
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
            BuildSizedBox(),
            Align(
              alignment: Alignment.topCenter,
              child: BuildText(
                'Job Details',
                size: 3.5,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            BuildSizedBox(),
            Expanded(
                child: Column(
              children: [
                BuildSizedBox(
                  height: 1.5,
                ),
                Expanded(
                    child: Stack(
                  children: [
                    Obx(
                      () => ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: GoogleMap(
                          zoomControlsEnabled: false,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          polylines: controller.polylines.value,
                          initialCameraPosition: controller.initialPos,
                          onMapCreated: (GoogleMapController mapController) {
                            if (!controller.mapController.isCompleted) {
                              controller.mapController.complete(mapController);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                )),
                BuildSizedBox(),
                Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: AppColors.white,
                        boxShadow: [AppStyles.tileShadowDark]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: makeImageLink(
                                    controller.job.userId.profileImage),
                                width: SizeConfig.imageSizeMultiplier * 18,
                                height: SizeConfig.imageSizeMultiplier * 18,
                                fit: BoxFit.cover,
                              ),
                            ),
                            BuildSizedBox(
                              width: 3,
                            ),
                            BuildText(
                              controller.job.userId.name.capitalize,
                              size: 2.8,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        BuildText(
                          controller.job.packageTitle,
                          color: AppColors.medViolet,
                          size: 2.4,
                          fontWeight: FontWeight.bold,
                        ),
                        BuildText(
                          'Description:',
                          color: AppColors.darkViolet,
                          size: 1.8,
                        ),
                        BuildText(
                          controller.job.packageDescription,
                          color: AppColors.medViolet,
                          fontWeight: FontWeight.bold,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BuildText(
                              'Delivery date:',
                              color: AppColors.darkViolet,
                              size: 1.8,
                            ),
                            BuildText(
                              makeDate(controller.job.deliveredDate),
                              color: AppColors.medViolet,
                              fontWeight: FontWeight.bold,
                              size: 1.8,
                            ),
                          ],
                        ),
                        BuildSizedBox(
                          height: 0.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BuildText(
                              'Amount:',
                              color: AppColors.darkViolet,
                              size: 1.8,
                            ),
                            BuildText(
                              makePrice(controller.job.finalBudget),
                              color: AppColors.medViolet,
                              fontWeight: FontWeight.bold,
                              size: 1.8,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BuildText(
                              'Your bidded price:',
                              color: AppColors.darkViolet,
                            ),
                            BuildText(
                              makePrice(controller.biddedprice),
                              color: AppColors.medViolet,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        BuildSizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Obx(
                              () => BuildPrimaryButton(
                                  isEnabled: controller.rateBtnEnable(),
                                  onTap: () => controller.toRate(),
                                  label: 'Review'),
                            )),
                            BuildSizedBox(
                              width: 2,
                            ),
                            Expanded(
                                child: BuildPrimaryButton(
                                    isEnabled:
                                        controller.status.value != 'completed',
                                    onTap: () => controller.toCall(),
                                    label: 'Call')),
                            BuildSizedBox(
                              width: 2,
                            ),
                            Expanded(
                                child: BuildPrimaryButton(
                                    isEnabled:
                                        controller.status.value != 'completed',
                                    onTap: () => controller.toDriverChat(),
                                    label: 'Chat')),
                          ],
                        ),
                        BuildSizedBox(),
                        Obx(() => BuildPrimaryButton(
                            isEnabled: controller.status.value != 'completed',
                            onTap: () => controller.decide(),
                            label: controller.status.value == 'upcoming'
                                ? 'Start job'
                                : 'Complete job'))
                      ],
                    )),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
