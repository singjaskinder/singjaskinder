import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/text_field.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'mobile_number_controller.dart';

class MobileNumber extends StatelessWidget {
  const MobileNumber({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MobileNumberController());
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BuildText(
              'Welcome!',
              size: 5.0,
              color: AppColors.violet,
            ),
            BuildText(
              'Enter your Mobile Number to login or register!',
              size: 2,
            ),
            BuildSizedBox(
              height: 12.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: BuildText(
                    '+91',
                    size: 3.5,
                    color: AppColors.violet,
                  ),
                ),
                BuildSizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Form(
                    key: controller.formKey,
                    child: BuildCustomTextField(
                      controller: controller.phoneCtrl,
                      textInputType: TextInputType.phone,
                      // label: 'Mobile Number',
                      prefixIcon: Icon(Feather.phone),
                      isDense: false,
                      maxLength: 10,
                      validator: (val) => Validation.validatePhone(val),
                    ),
                  ),
                )
              ],
            ),
            BuildSizedBox(
              height: 4.0,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: BuildPrimaryButton(
                onTap: () => controller.getCode(),
                label: 'Get OTP',
              ),
            ),
            BuildSizedBox(
              height: 1.3,
            ),
            Center(
              child: BuildText(
                'or',
                color: AppColors.black,
              ),
            ),
            BuildSizedBox(
              height: 1.3,
            ),
            Center(
              child: BuildSecondaryButton(
                  onTap: () => controller.toLogin(),
                  label: 'Login using password'),
            )
          ],
        ),
      ),
    );
  }
}
