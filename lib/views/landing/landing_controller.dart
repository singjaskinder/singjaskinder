import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/functions/preferences.dart';
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
    final savedPin = saved.getString('pin') ?? '';
    Future.delayed(Duration(seconds: 3), () {
      final authToken = saved.getString('auth_token');
      if (authToken != null || authToken != 'NA' || authToken.isNotEmpty) {
        if(savedPin.isNotEmpty){
        Get.offNamed(Routes.inputPin);

        }
        else{
        Get.offNamed(Routes.navigator);

        }
      } else {
        Get.offNamed(Routes.login);
      }
     
    });
  }
}
