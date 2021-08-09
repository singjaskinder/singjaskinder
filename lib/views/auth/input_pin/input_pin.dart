import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/text_field.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'input_pin_controller.dart';

class InputPin extends StatelessWidget {
  const InputPin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InputPinController());
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        BuildSizedBox(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: BuildText(
            'Enter pin',
            size: 3.5,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: BuildCustomTextField(
            hint: '4-digit Pin',
            controller: controller.pinCtrl,
            maxLength: 4,
            centerCursor: true,
            isPassword: true,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.number,
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: BuildPrimaryButton(
              onTap: () => controller.checkPin(), label: 'Confirm'),
        ),
      ]),
    );
  }
}
