import 'package:dio/dio.dart';
import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetOtpCodeController extends GetxController {
  BuildContext context;
  final formKey = GlobalKey<FormState>();
  final otpCtrl = TextEditingController();
  String email;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments;
  }

  void verifyCode() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        isLoading(true);
        final data = {'email': email, 'otp': otpCtrl.text};
        await ApiHandler.postHttp(EndPoints.postConfirmOtp, data);
        isLoading(false);
        toChangePassword();
      } on DioError catch (e) {
        isLoading(false);
        print(e.response);
        if (e.response.statusCode == 400) {
          BuildRetryBottomSheet(context, Routes.back,
              text: 'Enter OTP code is invalid',
              label: 'Okay',
              errored: true,
              cancellable: false);
          return;
        }
        BuildRetryBottomSheet(context, verifyCode);
      }
    }
  }

  void toChangePassword() {
    otpCtrl.clear();
    Get.toNamed(Routes.changePassword, arguments: email);
  }
}
