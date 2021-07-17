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
import 'change_password_controller.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());
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
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BuildSizedBox(
                height: 6,
              ),
              BuildText(
                'Change Password',
                size: 4.5,
                textAlign: TextAlign.center,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
              BuildSizedBox(
                height: 2,
              ),
              BuildText(
                '',
                size: 2.5,
                textAlign: TextAlign.center,
                color: AppColors.white,
              ),
              BuildSizedBox(height: 10),
              Obx(
                () => BuildCustomTextField(
                  controller: controller.passwordCtrl,
                  isPassword: !controller.showPassword.value,
                  textInputType: TextInputType.phone,
                  hint: 'Enter new password',
                  prefixIcon: Icon(Feather.lock),
                  suffixIcon: GestureDetector(
                    onTap: () => controller.togglePassword(),
                    child: Icon(
                      !controller.showPassword.value
                          ? Feather.eye
                          : Feather.eye_off,
                    ),
                  ),
                  validator: (val) => Validation.validatePassword(val),
                ),
              ),
              BuildSizedBox(height: 1.5),
              Obx(
                () => BuildCustomTextField(
                  controller: controller.passwordCtrl2,
                  isPassword: !controller.showPassword.value,
                  textInputType: TextInputType.phone,
                  hint: 'Enter new password again',
                  prefixIcon: Icon(Feather.lock),
                  suffixIcon: GestureDetector(
                    onTap: () => controller.togglePassword(),
                    child: Icon(
                      !controller.showPassword.value
                          ? Feather.eye
                          : Feather.eye_off,
                    ),
                  ),
                  validator: (val) => val == controller.passwordCtrl.text
                      ? null
                      : 'Passwords doesn\'t match',
                ),
              ),
              BuildSizedBox(
                height: 2.0,
              ),
              BuildPrimaryButton(
                onTap: () => controller.changePassword(),
                label: 'Change Password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
