import 'package:dio/dio.dart' as Dio;
import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/models/api_response/user_m.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/functions/preferences.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_profile/my_profile_controller.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_profile/profile_details/profile_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddAddressController extends GetxController {
  final ProfileDetailsController profileDetailsController = Get.find();
  final formKey = GlobalKey<FormState>();
  final stateCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final postalCtrl = TextEditingController();
  final fromNetwork = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAddress();
  }

  void getAddress() {
    if (profileDetailsController.address.value.isNotEmpty) {
      final addressContent = profileDetailsController.address.value.split('&&');
      stateCtrl.text = addressContent[0].capitalizeFirst;
      cityCtrl.text = addressContent[1].capitalizeFirst;
      addressCtrl.text = addressContent[2].capitalizeFirst;
      postalCtrl.text = addressContent[3];
    }
  }

  void setAddress() {
    profileDetailsController.address.value = stateCtrl.text +
        '&&' +
        cityCtrl.text +
        '&&' +
        addressCtrl.text +
        '&&' +
        postalCtrl.text;
    Preferences.saver
        .setString('address', profileDetailsController.address.value);
  }

  void updateAddress() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        final data = Dio.FormData.fromMap({
          'country': 'India',
          'state': stateCtrl.text.trim(),
          'city': cityCtrl.text.trim(),
          'address': addressCtrl.text.trim(),
          'postal_code': int.parse(postalCtrl.text.trim()),
        });
        isLoading(true);
        await ApiHandler.putHttp(EndPoints.putUpdateDriver, data);
        setAddress();
        isLoading(false);
        BuildRetryBottomSheet(Get.context, Get.back,
            text: 'Address details updated',
            label: 'OK',
            errored: false,
            cancellable: false);
      } on Dio.DioError catch (e) {
        print(e);
        isLoading(false);
        BuildRetryBottomSheet(Get.context, updateAddress,
            autoClose: true, errored: true, cancellable: false);
      }
    }
  }
}
