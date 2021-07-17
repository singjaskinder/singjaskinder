import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'congratulation_controller.dart';

class Congratulation extends StatelessWidget {
  const Congratulation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CongratulationController());
    return BuildViewWithBackground(
      hasBackButton: false,
      haveSafeArea: false,
      positionedImage: Positioned(
        bottom: -120,
        left: 0,
        right: 0,
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BuildSizedBox(height: 5),
            Image.asset(
              getImage('done.png'),
              width: SizeConfig.imageSizeMultiplier * 30,
            ),
            BuildSizedBox(
              height: 3,
            ),
            BuildText(
              'Yay!\nCongratulation!\nWelcome to',
              size: 5,
              textAlign: TextAlign.center,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
            BuildSizedBox(),
            Image.asset(
              getImage('logo.png'),
              width: SizeConfig.imageSizeMultiplier * 60,
            ),
            Spacer(),
            BuildPrimaryButton(
              onTap: () => controller.toHome(),
              label: 'Continue',
            )
          ],
        ),
      ),
    );
  }
}
