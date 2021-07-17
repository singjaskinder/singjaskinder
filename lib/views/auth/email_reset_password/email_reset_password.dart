import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/validation.dart';
import 'email_reset_password_controller.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text_field.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import '../../../res/app_colors.dart';
import '../../../common/text.dart';
import '../../../common/view_with_background.dart';
import '../../../common/buttons.dart';

class EmailResetPassword extends StatelessWidget {
  const EmailResetPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmailResetPasswordController());
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
              'Forgot your\nPassword?',
              size: 4.5,
              textAlign: TextAlign.center,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
            BuildSizedBox(
              height: 2,
            ),
            BuildText(
              'No problem! Just enter your\nregistered email address',
              size: 2.5,
              textAlign: TextAlign.center,
              color: AppColors.white,
            ),
            BuildSizedBox(height: 10),
            Form(
              key: controller.formKey,
              child: BuildCustomTextField(
                controller: controller.emailCtrl,
                textInputType: TextInputType.phone,
                hint: 'Email Address',
                prefixIcon: Icon(Feather.phone),
                validator: (val) => Validation.validateEmail(val),
              ),
            ),
            BuildSizedBox(
              height: 2.0,
            ),
            BuildPrimaryButton(
              onTap: () => controller.sendOtp(),
              label: 'Reset Password',
            ),
          ],
        ),
      ),
    );
  }
}
