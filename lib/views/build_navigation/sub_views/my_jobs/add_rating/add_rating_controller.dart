import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/job_m.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRatingController extends GetxController {
  Jobs job;
  final formKey = GlobalKey<FormState>();
  final descriptionCtrl = TextEditingController();
  int ratings = -1;

  @override
  void onInit() {
    super.onInit();
    final res = Get.arguments;
    job = res['job_details'];
  }

  void addRate() async {
    if (ratings == -1) {
      BuildRetryBottomSheet(Get.context, Get.back,
          text: 'Please add proper rating',
          label: 'OK',
          errored: true,
          cancellable: false);
      return;
    }
    if (formKey.currentState.validate()) {
      try {
        isLoading(true);
        final data = {
          'rating': ratings,
          'review': descriptionCtrl.text,
        };
        await ApiHandler.postHttp(EndPoints.postReview, data,
            params: job.sId + '/' + job.userId.sId);
        isLoading(false);
        Get.back(result: true);
      } catch (e) {
        print(e);
        isLoading(false);
        BuildRetryBottomSheet(Get.context, () {
          Get.back();
          addRate();
        }, errored: true, cancellable: false);
      }
    }
  }
}
