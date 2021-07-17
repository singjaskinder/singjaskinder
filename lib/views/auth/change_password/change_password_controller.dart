import 'package:dio/dio.dart';
import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/dialog.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  BuildContext context;

  final formKey = GlobalKey<FormState>();
  final showPassword = false.obs;
  final passwordCtrl = TextEditingController();
  final passwordCtrl2 = TextEditingController();
  String email;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments;
  }

  void togglePassword() =>
      showPassword.value = showPassword.value ? false : true;

  void changePassword() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        isLoading(true);
        final data = {'email': email, 'password': passwordCtrl2.text.trim()};
        await ApiHandler.putHttp(EndPoints.putResetPassword, data);
        isLoading(false);
        BuildRetryBottomSheet(context, toLogin,
            done: true,
            text: 'Password has been changed successfully',
            cancellable: false,
            label: 'Okay');
      } on DioError catch (e) {
        isLoading(false);
        print(e.response);
        BuildRetryBottomSheet(context, changePassword);
      }
    }
  }

  void toLogin() {
    Get.back();
    Get.back();
    Get.back();
    Get.back();
  }
}
