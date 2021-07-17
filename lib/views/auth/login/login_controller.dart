import 'package:dio/dio.dart';
import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/models/api_response/user_m.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/dialog.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/functions/preferences.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../overlays/progress_dialog.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  BuildContext context;

  final showPassword = false.obs;

  void togglePassword() =>
      showPassword.value = showPassword.value ? false : true;

  void toResetPassword() => Get.toNamed(Routes.emailresetPassword);

  void toRegister() => Get.toNamed(Routes.register);

  Future<void> login() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        await Preferences.getDeviceInfo();
        final data = {
          'email': emailCtrl.text.trim(),
          'password': passwordCtrl.text.trim(),
          'fcm_token': Preferences.getFcmToken(),
          // 'build': Preferences.getBuild(),
          // 'device_id': Preferences.getDeviceId(),
          // 'device': Preferences.getDevice(),
        };
        isLoading(true);
        final apiData = await ApiHandler.postHttp(EndPoints.postLogin, data);
        Preferences.saveUserDetails(UserM.fromJson(apiData.data));
        isLoading(false);
        Preferences.saver.setString('password', passwordCtrl.text.trim());
        Get.offAllNamed(Routes.navigator);
      } on DioError catch (e) {
        isLoading(false);
        print(e.response.data);
        if (e.response.statusCode == 401) {
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
                BuildText('Oops, Invalid email or password...',
                    size: 2.5,
                    color: AppColors.violet,
                    fontWeight: FontWeight.w400),
                BuildSizedBox(),
                BuildPrimaryButton(
                  onTap: () => Routes.back(),
                  label: 'Back to Login',
                ),
                BuildSizedBox(height: 1.6),
                BuildPrimaryButton(
                  onTap: () {
                    Routes.back();
                    emailCtrl.clear();
                    passwordCtrl.clear();
                    toRegister();
                  },
                  label: 'Sign Up',
                ),
              ],
            ),
          );

          return;
        } else
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
                  onTap: () {
                    Get.back();
                    login();
                  },
                  label: 'Try Again',
                ),
                BuildSizedBox(height: 1.6),
                BuildPrimaryButton(
                  onTap: () => Routes.back(),
                  label: 'Sign Up',
                ),
              ],
            ),
          );
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading(true);
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final data = {
        'idToken': googleAuth.idToken,
        'fcm_token': Preferences.getFcmToken(),
        'build': Preferences.getBuild(),
        'device_id': Preferences.getDeviceId(),
        'device': Preferences.getDevice(),
      };
      final apiData = await ApiHandler.postHttp(EndPoints.googleLogin, data);
      Preferences.saveUserDetails(UserM.fromJson(apiData.data));
      // String email = res.data['data'][0]['email'];
      // String name = res.data['data'][0]['name'];
      // Get.toNamed(Routes.mobileNumber, arguments: []);
      isLoading(false);
    } catch (e) {
      print(e);
      isLoading(false);
    }
  }

  // Future<void> signInWithFacebook() async {
  //   final fb = FacebookLogin();

  //   final res = await fb.logIn(permissions: [
  //     FacebookPermission.publicProfile,
  //     FacebookPermission.email,
  //   ]);

  //   switch (res.status) {
  //     case FacebookLoginStatus.success:
  //       isLoading(true);
  //       // final FacebookAccessToken accessToken = res.accessToken;
  //       final profile = await fb.getUserProfile();
  //       print('---------------');
  //       print(await fb.getUserEmail());
  //       print(profile.name);
  //       print('---------------');
  //       // final imageUrl = await fb.getProfileImageUrl(width: 100);
  //       final email = await fb.getUserEmail();
  //       emailCtrl.text = email;
  //       passwordCtrl.text = profile.name;
  //       isLoading(false);

  //       // But user can decline permission
  //       if (email != null) print('And your email is $email');

  //       break;
  //     case FacebookLoginStatus.cancel:
  //       // User cancel log in
  //       break;
  //     case FacebookLoginStatus.error:
  //       // Log in failed
  //       // print('Error while log in: ${res.error}');
  //       break;
  //   }
  // }

  @override
  void onClose() {
    super.onClose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }
}
