import 'package:dio/dio.dart';
import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/dialog.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailResetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  BuildContext context;

  void sendOtp() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        isLoading(true);
        final data = {'email': emailCtrl.text.trim()};
        await ApiHandler.postHttp(EndPoints.postSendOtpEmail, data);
        isLoading(false);
        BuildRetryBottomSheet(context, toResetPassword,
            done: true,
            text: 'Password reset link has been sent your email',
            label: 'Okay');
      } on DioError catch (e) {
        isLoading(false);
        print(e.response);
        if (e.response.statusCode == 404) {
          BuildRetryBottomSheet(context, Routes.back,
              text: 'Oops Enter email not found...', label: 'Okay');
          return;
        }
        BuildRetryBottomSheet(context, sendOtp);
      }
    }
  }

  void toResetPassword() {
    Get.toNamed(Routes.resetOtpCode, arguments: emailCtrl.text);
    emailCtrl.clear();
  }
}
