import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/social_login_row.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/text_field.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/overlays/dialog.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/validation.dart';
import 'package:dlivrDriver/views/auth/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'register_controller.dart';

class Register extends StatelessWidget {
  const Register({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    final controller = Get.put(RegisterController());
    controller.context = context;
    return BuildViewWithBackground(
      resizeToAvoidBottomInset: true,
      hasBackButton: true,
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BuildSizedBox(
                  height: 8,
                ),
                BuildText(
                  'Let\'s get started',
                  size: 5,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
                BuildSizedBox(
                  height: 2,
                ),
                BuildText(
                  'Create your account',
                  size: 2.5,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
                BuildSizedBox(height: 4),
                BuildCustomTextField(
                  controller: controller.nameCtrl,
                  textInputType: TextInputType.name,
                  hint: 'Full name',
                  prefixIcon: Icon(Feather.user),
                  validator: (val) => Validation.validateName(val),
                ),
                BuildSizedBox(
                  height: 1.5,
                ),
                BuildCustomTextField(
                  controller: controller.emailCtrl,
                  textInputType: TextInputType.emailAddress,
                  hint: 'Email Address',
                  prefixIcon: Icon(Feather.mail),
                  validator: (val) => Validation.validateEmail(val),
                ),
                BuildSizedBox(
                  height: 1.5,
                ),
                BuildCustomTextField(
                  controller: controller.phoneCtrl,
                  textInputType: TextInputType.phone,
                  hint: 'Phone',
                  prefixIcon: Icon(Feather.phone),
                  maxLength: 10,
                  validator: (val) => Validation.validatePhone(val),
                ),
                BuildSizedBox(
                  height: 1.5,
                ),
                Obx(
                  () => BuildCustomTextField(
                    hint: 'Password',
                    controller: controller.passwordCtrl,
                    isPassword: !controller.showPassword.value,
                    textInputAction: TextInputAction.done,
                    prefixIcon: Icon(Feather.lock),
                    suffixIcon: GestureDetector(
                      onTap: () => controller.togglePassword(),
                      child: Icon(
                        controller.showPassword.value
                            ? Feather.eye
                            : Feather.eye_off,
                      ),
                    ),
                    validator: (val) => Validation.validatePassword(val),
                  ),
                ),
                BuildSizedBox(
                  height: 2.5,
                ),
                BuildPrimaryButton(
                  onTap: () => controller.register(),
                  label: 'Sign Up',
                ),
                BuildSizedBox(height: 1.5),
                BuildText('or'),
                BuildSizedBox(),
                BuildSecondaryButton(
                  onTap: () => controller.toLogin(),
                  label: 'Back to Login',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
