import 'package:dio/dio.dart';
import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/overlays/dialog.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileNumberController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final phoneCtrl = TextEditingController();

  Future<void> getCode() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      final onPos = () async {
        try {
          final data = {
            'mobile': int.parse(phoneCtrl.text),
          };
          isLoading(true);
          final apiData =
              await ApiHandler.postHttp(EndPoints.postSendOtpEmail, data);
          if (apiData.statusCode == 200) {
            isLoading(false);
            Routes.back();
            Get.toNamed(Routes.otpCode, arguments: false);
          }
        } on DioError catch (e) {
          print(e);
          isLoading(false);
          Routes.back();
          BuildDialog(
              'Oops!', 'Something went wrong...', null, null, null, null);
        }
      };
      BuildDialog('Confirmation', 'Is +91 ' + phoneCtrl.text + ' Correct?',
          'Yes', 'No', onPos, null);
    }
  }

  void toLogin() => Get.toNamed(Routes.login);

  void toRegister() => Get.toNamed(Routes.register);
}
