import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    check();
  }

  void check() async {
    final saved = await SharedPreferences.getInstance();
    Future.delayed(Duration(seconds: 0), () {
      final authToken = saved.getString('auth_token');
      Get.offNamed(authToken == null || authToken == 'NA' || authToken.isEmpty
          ? Routes.login
          : Routes.navigator);
    });
  }
}
