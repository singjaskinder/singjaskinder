import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/user_image.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'tracking_details_controller.dart';

class TrackingDetails extends StatelessWidget {
  const TrackingDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrackingDetailsController());
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
                'Tracking Details',
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: SizeConfig.heightMultiplier * 9.5,
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.medViolet.withOpacity(0.5),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [AppStyles.tileShadowDark]),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.my_location_outlined,
                                  color: AppColors.white,
                                  size: SizeConfig.imageSizeMultiplier * 6,
                                ),
                                BuildSizedBox(
                                  width: 1.5,
                                ),
                                Expanded(
                                  child: BuildText(
                                    controller.job.pickAddress,
                                    color: AppColors.white,
                                    fontFamily: AppStyles.robotoB,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Icon(
                                  Feather.map_pin,
                                  color: AppColors.white,
                                  size: SizeConfig.imageSizeMultiplier * 6,
                                ),
                                BuildSizedBox(
                                  width: 1.5,
                                ),
                                Expanded(
                                  child: BuildText(
                                    controller.job.dropAddress,
                                    color: AppColors.white,
                                    fontFamily: AppStyles.robotoB,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
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
                            BuildText(
                              controller.job.packageTitle,
                              color: AppColors.medViolet,
                              size: 3,
                              fontWeight: FontWeight.bold,
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: AppColors.medViolet,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(18))),
                                  child: BuildText(
                                    controller.job.driverDetails.name,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    size: 1.8,
                                  ),
                                ),
                                BuildSizedBox(),
                                controller.image.isEmpty
                                    ? CircleAvatar(
                                        radius:
                                            SizeConfig.imageSizeMultiplier * 8,
                                        backgroundColor: AppColors.lightViolet,
                                        child: Icon(
                                          Feather.user,
                                          size: SizeConfig.imageSizeMultiplier *
                                              5.5,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius:
                                            SizeConfig.imageSizeMultiplier * 8,
                                        backgroundColor: AppColors.lightViolet,
                                        backgroundImage:
                                            NetworkImage(controller.image),
                                      ),
                              ],
                            )
                          ],
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
                        BuildSizedBox(),
                        GetBuilder<TrackingDetailsController>(
                            builder: (controller) {
                          return Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => BuildPrimaryButton(
                                      isEnabled: !controller.isTipAdded.value,
                                      onTap: () => controller.toAddTip(),
                                      label: 'Add tip'),
                                ),
                              ),
                              BuildSizedBox(
                                width: 2,
                              ),
                              Expanded(
                                child: Obx(
                                  () => BuildPrimaryButton(
                                      isEnabled: !controller.isRateDone.value,
                                      onTap: () => controller.toRateDriver(),
                                      label: 'Rate'),
                                ),
                              ),
                            ],
                          );
                        })
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
