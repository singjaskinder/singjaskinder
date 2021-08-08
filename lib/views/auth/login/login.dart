import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text_field.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import '../../../res/app_colors.dart';
import '../../../common/text.dart';
import '../../../common/view_with_background.dart';
import '../../../common/buttons.dart';
import 'login_controller.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    controller.context = context;
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
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BuildSizedBox(
                height: 4,
              ),
              BuildText(
                'Hello!',
                size: 8.5,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
              BuildText(
                'Login to your account',
                size: 2.4,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
              BuildSizedBox(height: 3),
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
              Container(
                alignment: Alignment.centerRight,
                child: BuildSecondaryButton(
                  onTap: () => controller.toResetPassword(),
                  label: 'Forgot Password?',
                ),
              ),
              BuildSizedBox(),
              BuildPrimaryButton(
                onTap: () => controller.login(),
                label: 'Login',
              ),
              BuildSizedBox(height: 1.5),
              Visibility(
                visible: false,
                child: BuildPrimaryButton(
                  // onTap: () => Get.toNamed(Routes.navigator),
                  onTap: () => controller.login(),
                  label: 'Facebook',
                  color: AppColors.darkBlue,
                ),
              ),
              BuildText('or'),
              BuildSizedBox(height: 1.5),
              Visibility(visible: false, child: BuildSizedBox(height: 1.5)),
              // BuildPrimaryButton(
              //   // onTap: () => Get.toNamed(Routes.navigator),
              //   onTap: () => controller.signInWithGoogle(),
              //   label: 'Google',
              //   color: AppColors.darkred,
              // ),
              Spacer(),
              BuildText('Don\'t have a account?', color: AppColors.darkViolet),
              BuildSizedBox(),
              BuildPrimaryButton(
                onTap: () => controller.toRegister(),
                label: 'Sign Up',
                color: AppColors.violet,
                isOutLined: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
