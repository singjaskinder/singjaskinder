import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/utils/functions/preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final oldPasswordCtrl = TextEditingController();
  final passwordCtrl1 = TextEditingController();
  final passwordCtrl2 = TextEditingController();
  final showOldPassword = false.obs;
  final showPassword1 = false.obs;
  final showPassword2 = false.obs;

  void toggleOldPassword() =>
      showOldPassword.value = showOldPassword.value ? false : true;
 
  void togglePassword1() =>
      showPassword1.value = showPassword1.value ? false : true;

  void togglePassword2() =>
      showPassword2.value = showPassword2.value ? false : true;

  void updatePassword() async {
    if (formKey.currentState.validate()) {
      final res = Preferences.saver.getString('password');
      if (res != null && res != oldPasswordCtrl.text.trim()) {
        BuildRetryBottomSheet(Get.context, Get.back,
            text: 'Incorrect old password',
            label: 'OK',
            errored: true,
            cancellable: false);
        return;
      }
      try {
        isLoading(true);
        final data = {
          'password': passwordCtrl2.text.trim(),
        };
        await ApiHandler.putHttp(EndPoints.updatePassword, data);
        oldPasswordCtrl.clear();
        passwordCtrl1.clear();
        passwordCtrl2.clear();
        Preferences.saver.setString('password', passwordCtrl2.text);
        isLoading(false);
        BuildRetryBottomSheet(Get.context, Get.back,
            text: 'Password changed successfully',
            label: 'OK',
            done: true,
            errored: true,
            cancellable: false);
      } catch (e) {
        print(e);
        isLoading(false);
        BuildRetryBottomSheet(Get.context, () {
          Get.back();
          updatePassword();
        }, errored: true, cancellable: false);
      }
    }
  }
}
