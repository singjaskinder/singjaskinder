import 'package:cached_network_image/cached_network_image.dart';
import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/text_field.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'bid_price_controller.dart';

class BidPrice extends StatelessWidget {
  const BidPrice({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BidPriceController());
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
                'Bid Price',
                size: 3.5,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            BuildSizedBox(
              height: 2,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.widthMultiplier * 90,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Feather.info,
                            color: AppColors.medViolet,
                          )),
                      BuildText(
                        'Customer\'s budget\n' +
                            makePrice(controller.job.finalBudget),
                        color: AppColors.darkViolet,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                        size: 2.6,
                      ),
                      BuildSizedBox(
                        height: 2,
                      ),
                      Obx(() => BuildText(
                            'Note:\nYou can re-edit your bid price only ' +
                                (3 -
                                        controller.jobDetailsController.bidCount
                                            .value)
                                    .toString() +
                                ' times on this job',
                            size: 1.8,
                          )),
                      BuildSizedBox(),
                    ],
                  ),
                ),
                BuildSizedBox(
                  height: 3,
                ),
                BuildSizedBox(),
                BuildCustomTextField(
                  controller: controller.priceCtrl,
                  textInputType: TextInputType.number,
                  hint: 'Enter Your Bid Price',
                  centerCursor: true,
                  textInputAction: TextInputAction.done,
                ),
                Spacer(),
                Obx(() => BuildPrimaryButton(
                    isEnabled:
                        controller.jobDetailsController.bidCount.value < 3,
                    onTap: () => controller.bid(),
                    label: 'Done'))
              ],
            )),
          ],
        ),
      ),
    );
  }
}
