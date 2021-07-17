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
import 'set_pin_controller.dart';

class SetPin extends StatelessWidget {
  const SetPin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SetPinController());
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
              'Change pin',
              size: 3.5,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          BuildSizedBox(
            height: 3,
          ),
          Visibility(
            visible: controller.isSavedPin,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(
                () => BuildCustomTextField(
                  hint: '4-digit old pin',
                  controller: controller.oldPinCtrl,
                  isPassword: !controller.showOldPin.value,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                  prefixIcon: Icon(Feather.lock),
                  suffixIcon: GestureDetector(
                    onTap: () => controller.toggleOldPin(),
                    child: Icon(
                      controller.showOldPin.value
                          ? Feather.eye
                          : Feather.eye_off,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(
              () => BuildCustomTextField(
                hint: '4-digit new Pin',
                controller: controller.pinCtrl1,
                isPassword: !controller.showPin1.value,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.number,
                prefixIcon: Icon(Feather.lock),
                suffixIcon: GestureDetector(
                  onTap: () => controller.togglePin1(),
                  child: Icon(
                    controller.showPin1.value ? Feather.eye : Feather.eye_off,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(
              () => BuildCustomTextField(
                hint: '4-digit confirm Pin',
                controller: controller.pinCtrl2,
                isPassword: !controller.showPin2.value,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.number,
                prefixIcon: Icon(Feather.lock),
                suffixIcon: GestureDetector(
                  onTap: () => controller.togglePin2(),
                  child: Icon(
                    controller.showPin2.value ? Feather.eye : Feather.eye_off,
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BuildPrimaryButton(
                onTap: () => controller.updatePin(),
                label: (controller.isSavedPin ? 'Update' : 'Set') + ' Pin'),
          ),
        ]),
      ),
    );
  }
}
