import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/phone_check_m.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import '../../../routes/app_routes.dart';
import '../login/login_controller.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final loginController = Get.find<LoginController>();
  final showPassword = false.obs;
  LocationData locationData;
  BuildContext context;

  void togglePassword() =>
      showPassword.value = showPassword.value ? false : true;

  void toLogin() => Routes.back();

  void register() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      emailCtrl.text = emailCtrl.text.trim();
      phoneCtrl.text = phoneCtrl.text.trim();
      passwordCtrl.text = passwordCtrl.text.trim();
      isLoading(true);
      final phoneRes = await ApiHandler.getHttp(EndPoints.getCheckPhone,
          params: phoneCtrl.text);
      final emailRes =
          await ApiHandler.getHttp(EndPoints.getCheckEmail, params: phoneCtrl.text);
      isLoading(false);
      final phoneCheck = PhoneCheckM.fromJson(phoneRes.data);
      final emailCheck = PhoneCheckM.fromJson(emailRes.data);
      if (!phoneCheck.status && !emailCheck.status) {
        Get.toNamed(Routes.otpCode);
      } else {
        BuildRetryBottomSheet(context, Routes.back,
            text: 'Oops\nUser already exists...',
            label: 'OK',
            errored: true,
            cancellable: false);
      }
    }
  }

  void getLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        // toEnabledLocation();
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        // toEnabledLocation();
      }
    }

    isLoading(true);
    LocationData locationData = await location.getLocation();
    isLoading(false);
  }
}
