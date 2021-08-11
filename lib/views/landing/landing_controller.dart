import 'package:dlivrDriver/apis/local_auth_api.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/functions/preferences.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    check();
  }

  void check() async {
    final saved = await SharedPreferences.getInstance();
    String authToken = saved.getString('auth_token') ?? '';
    if (authToken.contains('NA')) {
      authToken = '';
    }
    final useLock = saved.getBool('use_lock') ?? false;
    Future.delayed(Duration(seconds: 3), () async {
      print(authToken);
      if (authToken.isNotEmpty) {
        if (useLock) {
          await lockCheck();
        } else {
          Get.offNamed(Routes.navigator);
        }
      } else {
        Get.offNamed(Routes.login);
      }
    });
  }

  Future<void> lockCheck() async {
    final isAuthenticated = await LocalAuthApi.authenticate();
    try {
      isAuthenticated
          ? Get.offAndToNamed(Routes.navigator)
          : SystemNavigator.pop();
    } catch (e) {
      print(e);
      Preferences.clearAll();
      Get.offAndToNamed(Routes.login);
      Future.delayed(Duration(seconds: 1), () {
        BuildRetryBottomSheet(Get.context, Routes.back,
            text:
                'Please add PIN, pattern, password, face, or fingerprint in settings of your phone',
            errored: true,
            cancellable: false);
      });
    }
  }
}
