import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/functions/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InputPinController extends GetxController {
  final pinCtrl = TextEditingController();
  String savedPin;

  @override
  void onInit() {
    super.onInit();
    savedPin = Preferences.saver.getString('pin') ?? '';
  }

  void checkPin() {
    if (pinCtrl.text.isNotEmpty) {
      if (pinCtrl.text.trim() == savedPin) {
        Get.offAllNamed(Routes.navigator);
      } else {
        BuildRetryBottomSheet(Get.context, Get.back,
            text: 'Entered PIN is incorrect',
            label: 'OK',
            errored: true,
            cancellable: false);
      }
    } else {
      BuildRetryBottomSheet(Get.context, Get.back,
          text: 'Please entered your 4-digit PIN',
          label: 'OK',
          errored: true,
          cancellable: false);
    }
  }
}
