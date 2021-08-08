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
              height: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BuildText(
                  'Your Bid Price',
                  size: 3.2,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
                BuildSizedBox(),
                BuildCustomTextField(
                  controller: controller.priceCtrl,
                  textInputType: TextInputType.number,
                  hint: '',
                  centerCursor: true,
                  textInputAction: TextInputAction.done,
                ),
                BuildSizedBox(
                  height: 3,
                ),
                BuildText(
                  'Customer\'s budget\n' +
                      makePrice(controller.job.finalBudget),
                  color: AppColors.white,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
                Spacer(),
                BuildPrimaryButton(
                    onTap: () => controller.bid(), label: 'Confirm')
              ],
            )),
          ],
        ),
      ),
    );
  }
}
