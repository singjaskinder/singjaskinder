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
import 'update_password_controller.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePasswordController());
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
      child: Form(
        key: controller.formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          BuildSizedBox(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BuildText(
              'Change password',
              size: 3.5,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          BuildSizedBox(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(
              () => BuildCustomTextField(
                hint: 'Old password',
                controller: controller.oldPasswordCtrl,
                isPassword: !controller.showOldPassword.value,
                textInputAction: TextInputAction.done,
                prefixIcon: Icon(Feather.lock),
                suffixIcon: GestureDetector(
                  onTap: () => controller.toggleOldPassword(),
                  child: Icon(
                    controller.showOldPassword.value
                        ? Feather.eye
                        : Feather.eye_off,
                  ),
                ),
                validator: (val) => Validation.validatePassword(val),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(
              () => BuildCustomTextField(
                hint: 'New password',
                controller: controller.passwordCtrl1,
                isPassword: !controller.showPassword1.value,
                textInputAction: TextInputAction.done,
                prefixIcon: Icon(Feather.lock),
                suffixIcon: GestureDetector(
                  onTap: () => controller.togglePassword1(),
                  child: Icon(
                    controller.showPassword1.value
                        ? Feather.eye
                        : Feather.eye_off,
                  ),
                ),
                validator: (val) => Validation.validatePassword(val),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(
              () => BuildCustomTextField(
                hint: 'Confirm password',
                controller: controller.passwordCtrl2,
                isPassword: !controller.showPassword2.value,
                textInputAction: TextInputAction.done,
                prefixIcon: Icon(Feather.lock),
                suffixIcon: GestureDetector(
                  onTap: () => controller.togglePassword2(),
                  child: Icon(
                    controller.showPassword2.value
                        ? Feather.eye
                        : Feather.eye_off,
                  ),
                ),
                validator: (val) => val.isNotEmpty
                    ? val == controller.passwordCtrl1.text
                        ? null
                        : 'Passwords don\'t match'
                    : 'Please enter valid password',
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BuildPrimaryButton(
                onTap: () => controller.updatePassword(),
                label: 'Update Password'),
          ),
        ]),
      ),
    );
  }
}
