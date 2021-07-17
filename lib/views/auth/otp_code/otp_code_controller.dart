import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/models/api_response/user_m.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/dialog.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/functions/preferences.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:dlivrDriver/views/auth/register/register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpCodeController extends GetxController {
  RegisterController registerController = Get.find();
  BuildContext context;
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final otpCtrl = TextEditingController();
  String phoneNo;
  String verId;
  final countdown = 60.obs;
  Timer _timer;

  @override
  void onInit() {
    super.onInit();
    phoneNo = registerController.phoneCtrl.text;
    sendOTPCode();
  }

  void sendOTPCode() async {
    final PhoneVerificationCompleted verificationCompleted =
        (phoneAuthCredential) async {
      try {
        await register();
      } catch (e) {
        String error;
        cancelTimer();
        if (e.toString().contains('User has already been linked')) {
          error = 'Phone number already in use';
        }
        BuildRetryBottomSheet(context, Routes.back,
            text: error, errored: true, cancellable: false);
        Future.delayed(Duration(seconds: 2), () {
          Get.back(closeOverlays: true);
        });
      }
    };

    final PhoneVerificationFailed verificationFailed = (exception) {
      BuildRetryBottomSheet(context, Routes.back,
          text: 'OTP verification failed', errored: true, cancellable: false);
      Future.delayed(Duration(seconds: 2), () {
        Get.back(closeOverlays: true);
      });
      cancelTimer();
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      verId = verificationId;
      startTimer();
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      cancelTimer();
    };

    await auth.verifyPhoneNumber(
        phoneNumber: '+91' + phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void submitOTP() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        PhoneAuthProvider.credential(
            verificationId: verId, smsCode: otpCtrl.text);
        await register();
      } catch (e) {
        isLoading(false);
        String error;
        cancelTimer();
        if (e.toString().contains('User has already been linked')) {
          error = 'Phone number already in use';
        }
        BuildRetryBottomSheet(context, Routes.back,
            text: error, errored: true, cancellable: false);
        Future.delayed(Duration(seconds: 2), () {
          Get.back(closeOverlays: true);
        });
      }
    }
  }

  void startTimer() {
    countdown.value = 60;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (countdown.value == 0) {
        timer.cancel();
      } else {
        countdown.value = countdown.value - 1;
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    countdown.value = 0;
  }

  @override
  void onClose() {
    cancelTimer();
    super.onClose();
  }

  Future<void> register() async {
    cancelTimer();
    await Preferences.getDeviceInfo();
    try {
      final data = {
        'name': registerController.nameCtrl.text.trim(),
        'email': registerController.emailCtrl.text.trim(),
        'phone': registerController.phoneCtrl.text.trim(),
        'password': registerController.passwordCtrl.text.trim(),
        'fcm_token': Preferences.getFcmToken(),
        'build': Preferences.getBuild(),
        'device_id': Preferences.getDeviceId(),
        'device': Preferences.getDevice(),
      };
      isLoading(true);
      final apiData = await ApiHandler.postHttp(EndPoints.postRegister, data);
      Preferences.saveUserDetails(UserM.fromJson(apiData.data));
      isLoading(false);
      Preferences.saver
          .setString('password', registerController.passwordCtrl.text.trim());
      toCongratulations();
    } on DioError catch (e) {
      print(e.response.data);
      isLoading(false);
      if (e.response.statusCode == 400) {
        BuildBottomSheet(
          context,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                getImage('info.png'),
                width: SizeConfig.imageSizeMultiplier * 30,
              ),
              BuildSizedBox(),
              BuildText('Oops, User already exists with entered email...',
                  size: 2.5,
                  textAlign: TextAlign.center,
                  color: AppColors.violet,
                  fontWeight: FontWeight.w400),
              BuildSizedBox(),
              BuildPrimaryButton(
                onTap: () => Routes.back(),
                label: 'Okay',
              ),
              BuildSizedBox(height: 1.6),
              BuildPrimaryButton(
                onTap: () {
                  Routes.back();
                  Routes.back();
                  Routes.back();
                },
                label: 'Back to Login',
              ),
            ],
          ),
        );
        return;
      }
      BuildBottomSheet(
        context,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              getImage('info.png'),
              width: SizeConfig.imageSizeMultiplier * 30,
            ),
            BuildSizedBox(),
            BuildText('Oops, Something Went wrong...',
                size: 2.5,
                color: AppColors.violet,
                fontWeight: FontWeight.w400),
            BuildSizedBox(),
            BuildPrimaryButton(
              onTap: () => register(),
              label: 'Try Again',
            ),
            BuildSizedBox(height: 1.6),
            BuildPrimaryButton(
              onTap: () => Routes.back(),
              label: 'Login',
            ),
          ],
        ),
      );
    }
  }

  void toCongratulations() => Get.offAllNamed(Routes.congratulation);
}
