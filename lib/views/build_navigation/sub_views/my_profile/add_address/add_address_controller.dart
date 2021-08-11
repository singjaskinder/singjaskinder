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
  final suburbCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final streetCtrl = TextEditingController();
  final postalCtrl = TextEditingController();
  final states = [
    'New South Wales',
    'Queensland',
    'South Australia',
    'Tasmania',
    'Victoria',
    'Western Australia'
  ];
  final selectedState = ''.obs;

  @override
  void onInit() {
    super.onInit();
    selectedState.value = null;
    getAddress();
  }

  void getAddress() {
    if (profileDetailsController.address.value.isNotEmpty) {
      final addressContent = profileDetailsController.address.value.split('&&');
      addressCtrl.text = addressContent[0].capitalizeFirst;
      streetCtrl.text = addressContent[1].capitalizeFirst;
      suburbCtrl.text = addressContent[2].capitalizeFirst;
      selectedState.value = addressContent[3];
      postalCtrl.text = addressContent[4];
    }
  }

  void setAddress() {
    profileDetailsController.address.value = addressCtrl.text +
        '&&' +
        streetCtrl.text +
        '&&' +
        suburbCtrl.text +
        '&&' +
        selectedState.value +
        '&&' +
        postalCtrl.text;
    Preferences.saver
        .setString('address', profileDetailsController.address.value);
  }

  void updateAddress() async {
    if (selectedState.value == null) {
      BuildRetryBottomSheet(Get.context, Get.back,
          text: 'Please select your State',
          label: 'OK',
          errored: true,
          cancellable: false);
      return;
    }
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        final data = Dio.FormData.fromMap({
          'address': addressCtrl.text.trim(),
          'street': streetCtrl.text.trim(),
          'city': suburbCtrl.text.trim(),
          'state': selectedState.value,
          'postal_code': int.parse(postalCtrl.text.trim()),
          'country': 'Australia',
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
