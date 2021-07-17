import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'job_added_details_controller.dart';

class JobAddedDetails extends StatelessWidget {
  const JobAddedDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobAddedDetailsController());
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
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [AppStyles.tileShadowDark]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildText(
                        controller
                            .homeController
                            .jobtypes[
                                controller.homeController.jobTypeSelected.value]
                            .title,
                        color: AppColors.medViolet,
                        size: 3,
                        fontWeight: FontWeight.bold,
                      ),
                      BuildSizedBox(),
                      BuildText(
                        'Description:',
                        color: AppColors.darkViolet,
                        size: 1.8,
                      ),
                      BuildText(
                        controller.homeController.descriptionCtrl.text,
                        color: AppColors.medViolet,
                        fontWeight: FontWeight.bold,
                      ),
                      BuildSizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BuildText(
                                'Package size:',
                                color: AppColors.darkViolet,
                                size: 1.8,
                              ),
                              BuildText(
                                controller.homeController.packageSizeCtrl.text,
                                color: AppColors.medViolet,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BuildText(
                                'Package weight:',
                                color: AppColors.darkViolet,
                                size: 1.8,
                              ),
                              BuildText(
                                controller
                                    .homeController.packageWeightCtrl.text,
                                color: AppColors.medViolet,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          )
                        ],
                      ),
                      BuildSizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildText(
                            'Delivery date:',
                            color: AppColors.darkViolet,
                            size: 1.8,
                          ),
                          BuildText(
                            makeDate(controller
                                .homeController.selectedDeliveryDate.value),
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
                            makePrice(
                                controller.homeController.finalBudget.value),
                            color: AppColors.medViolet,
                            fontWeight: FontWeight.bold,
                            size: 1.8,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                BuildSizedBox(
                  height: 1.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: BuildText(
                    'Note:\nAmount of estimated budget is been reserved from your wallet',
                    color: AppColors.white,
                    size: 1.8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                BuildPrimaryButton(
                    onTap: () => controller.onDone(), label: 'Done'),
                BuildSizedBox(
                  height: 1.5,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
