import 'package:dlivrDriver/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void isLoading(bool status) {
  status
      ? Get.dialog(const Center(child: CircularProgressIndicator(
        color: AppColors.medViolet,
      )),
          barrierDismissible: false)
      : Get.back();
}
