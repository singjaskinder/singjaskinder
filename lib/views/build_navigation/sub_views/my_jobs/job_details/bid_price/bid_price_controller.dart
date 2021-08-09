import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/job_m.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BidPriceController extends GetxController {
  final priceCtrl = TextEditingController();
  Jobs job;

  @override
  void onInit() {
    super.onInit();
    final res = Get.arguments;
    job = res['job_details'];
  }

  void bid() async {
    if (priceCtrl.text.isEmpty) {
      return;
    }
    try {
      isLoading(true);
      final data = {'bid': priceCtrl.text, 'remark': ''};
      await ApiHandler.postHttp(EndPoints.bidJob, data, params: job.sId);
      HomeController homeController = Get.find();
      homeController.update();

      isLoading(false);
      final onPos = () {
        Get.back(result: true);
      };
      BuildRetryBottomSheet(Get.context, onPos,
          text: 'Your bidding details \nis submitted',
          label: 'OK',
          errored: true,
          cancellable: false,
          autoClose: true);
    } on DioError catch (e) {
      print(e);
      isLoading(false);
      BuildRetryBottomSheet(Get.context, bid,
          errored: true, cancellable: false, autoClose: true);
    }
  }
}
