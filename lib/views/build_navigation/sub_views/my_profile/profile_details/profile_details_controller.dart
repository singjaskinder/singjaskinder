import 'package:dio/dio.dart' as Dio;
import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/common/bottom_sheet_image.dart';
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

class ProfileDetailsController extends GetxController {
  final BuildNavigationController buildNavigationController = Get.find();
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final fromNetwork = false.obs;
  final address = ''.obs;

  @override
  void onInit() {
    super.onInit();
    nameCtrl.text = Preferences.getName() ?? '';
    emailCtrl.text = Preferences.saver.getString('email') ?? '';
    phoneCtrl.text = Preferences.getPhone() ?? '';
    address.value = Preferences.saver.getString('address') ?? '';
    if (buildNavigationController.imageUrl.contains('https')) {
      fromNetwork.value = true;
    } else {
      fromNetwork.value = false;
    }
  }

  void toAddAddress() => Get.toNamed(Routes.addAddress);

  Addresses getAddress() {
    final addressContent = address.value.split('&&');
    return Addresses(
        state: addressContent[0].capitalizeFirst,
        city: addressContent[1].capitalizeFirst,
        address: addressContent[2].capitalizeFirst,
        postalCode: int.parse(addressContent[3]));
  }

  void imageControl() {
    if (buildNavigationController.imageUrl.value.isEmpty) {
      showImageBottomSheet();
    } else {
      buildNavigationController.imageUrl.value = '';
    }
  }

  void showImageBottomSheet() {
    showModalBottomSheet(
      context: Get.context,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      builder: (_) {
        return BuildSelectImageBottomSheet(
          onGalleryTap: () {
            Get.back();
            getImage(false);
          },
          onCameraTap: () {
            Get.back();
            getImage(true);
          },
        );
      },
    );
  }

  Future<void> getImage(bool fromCamera) async {
    final picker = ImagePicker();
    PickedFile imageFile;
    if (fromCamera) {
      imageFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 40,
      );
    } else {
      imageFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 40,
      );
    }
    if (imageFile == null) {
      return;
    }
    buildNavigationController.imageUrl.value = imageFile.path;
    fromNetwork.value = false;
    updateImage();
  }

  void updateDetails() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        final data = Dio.FormData.fromMap({'name': nameCtrl.text});
        Preferences.saver.setString('name', nameCtrl.text);
        isLoading(true);
        await ApiHandler.putHttp(EndPoints.putUpdateDriver, data,
            isDefault: false);
        isLoading(false);
        BuildRetryBottomSheet(Get.context, Get.back,
            text: 'Profile details updated',
            label: 'OK',
            errored: false,
            cancellable: false);
      } on Dio.DioError catch (e) {
        print(e);
        isLoading(false);
        BuildRetryBottomSheet(Get.context, updateDetails,
            errored: true, cancellable: false);
      }
    }
  }

  void updateImage() async {
    try {
      final data = Dio.FormData.fromMap({
        'driver_profile': await Dio.MultipartFile.fromFile(
            buildNavigationController.imageUrl.value,
            contentType: MediaType('image', 'jpeg'))
      });
      isLoading(true);
      final res = await ApiHandler.putHttp(EndPoints.putUpdateDriver, data,
          isDefault: false);
      print(res.data);
      Preferences.saver.setString('image',
          makeImageLink(UserM.fromJson(res.data).userData[0].profileImage));
      Future.delayed(Duration(milliseconds: 200), () {
        fromNetwork.value = true;
        buildNavigationController.imageUrl.value = Preferences.getImage();
      });
      isLoading(false);
      BuildRetryBottomSheet(Get.context, Get.back,
          text: 'Profile Image updated',
          label: 'OK',
          done: true,
          errored: true,
          cancellable: false);
    } on Dio.DioError catch (e) {
      print(e);
      isLoading(false);
      BuildRetryBottomSheet(Get.context, updateDetails,
          errored: true, cancellable: false);
    }
  }
}
