import 'package:dio/dio.dart' as Dio;
import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/common/bottom_sheet_image.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/models/api_response/user_m.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/functions/preferences.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/views/build_navigation/build_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/src/media_type.dart';

class MyProfileController extends GetxController {
  void toProfileDetails() => Get.toNamed(Routes.profileDetails);

  void toSetPin() => Get.toNamed(Routes.setPin);

  void toUpdatePassword() => Get.toNamed(Routes.updatePassword);
}
