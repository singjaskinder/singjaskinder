import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/utils/functions/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SetPinController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final oldPinCtrl = TextEditingController();
  final pinCtrl1 = TextEditingController();
  final pinCtrl2 = TextEditingController();
  final showOldPin = false.obs;
  final showPin1 = false.obs;
  final showPin2 = false.obs;
  bool isSavedPin = false;
  String savedPin;

  @override
  void onInit() {
    super.onInit();
    savedPin = Preferences.saver.getString('pin') ?? '';
    print('--------------savedPin');
    print(savedPin + 'dd');
    print('--------------savedPin');
    isSavedPin = savedPin.isNotEmpty;
  }

  void toggleOldPin() => showOldPin.value = showOldPin.value ? false : true;

  void togglePin1() => showPin1.value = showPin1.value ? false : true;

  void togglePin2() => showPin2.value = showPin2.value ? false : true;

  void updatePin() async {
    if (isSavedPin) {
      if (oldPinCtrl.text.trim() != savedPin) {
        BuildRetryBottomSheet(Get.context, Get.back,
            text: 'Incorrect old pin',
            label: 'OK',
            errored: true,
            cancellable: false);
        return;
      } else if (pinCtrl1.text != pinCtrl2.text) {
        BuildRetryBottomSheet(Get.context, Get.back,
            text: 'Incorrect entered pins',
            label: 'OK',
            errored: true,
            cancellable: false);
        return;
      } else if (pinCtrl1.text == pinCtrl2.text && pinCtrl2.text.length == 4) {
        Preferences.saver.setString('pin', pinCtrl2.text);
        oldPinCtrl.clear();
        pinCtrl1.clear();
        pinCtrl2.clear();
        BuildRetryBottomSheet(Get.context, Get.back,
            text: 'Pin Set',
            label: 'OK',
            done: true,
            errored: true,
            cancellable: false);
      } else {
        BuildRetryBottomSheet(Get.context, Get.back,
            text: 'Incorrect entered pins, should be 4-digts',
            label: 'OK',
            errored: true,
            cancellable: false);
      }
    } else {
      if (pinCtrl1.text != pinCtrl2.text) {
        BuildRetryBottomSheet(Get.context, Get.back,
            text: 'Incorrect entered pins',
            label: 'OK',
            errored: true,
            cancellable: false);
        return;
      } else if (pinCtrl1.text == pinCtrl2.text && pinCtrl2.text.length == 4) {
        Preferences.saver.setString('pin', pinCtrl2.text);
        pinCtrl1.clear();
        pinCtrl2.clear();
        BuildRetryBottomSheet(Get.context, Get.back,
            text: 'Pin Set',
            label: 'OK',
            done: true,
            errored: true,
            cancellable: false);
      } else {
        BuildRetryBottomSheet(Get.context, Get.back,
            text: 'Incorrect entered pins, should be 4-digts',
            label: 'OK',
            errored: true,
            cancellable: false);
      }
    }
  }
}
