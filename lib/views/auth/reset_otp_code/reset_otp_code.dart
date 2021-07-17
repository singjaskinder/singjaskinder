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
import 'reset_otp_code_controller.dart';

class ResetOtpCode extends StatelessWidget {
  const ResetOtpCode({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetOtpCodeController());
    controller.context = context;
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
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BuildSizedBox(
              height: 6,
            ),
            BuildText(
              'Enter 6-digit \nOTP',
              size: 4.5,
              textAlign: TextAlign.center,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
            BuildSizedBox(
              height: 2,
            ),
            BuildText(
              'An mail has been sent to entered email containing the otp code',
              size: 2.5,
              textAlign: TextAlign.center,
              color: AppColors.white,
            ),
            BuildSizedBox(height: 10),
            Form(
              key: controller.formKey,
              child: BuildCustomTextField(
                controller: controller.otpCtrl,
                textInputType: TextInputType.phone,
                hint: '6 digit otp code',
                prefixIcon: Icon(Feather.lock),
                maxLength: 6,
                validator: (val) => Validation.validateOTPCode(val),
              ),
            ),
            BuildSizedBox(
              height: 2.0,
            ),
            BuildPrimaryButton(
              onTap: () => controller.verifyCode(),
              label: 'Verify',
            ),
          ],
        ),
      ),
    );
  }
}
