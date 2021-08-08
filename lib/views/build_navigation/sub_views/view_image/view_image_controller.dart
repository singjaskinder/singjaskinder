import 'package:get/get.dart';

class ViewImageController extends GetxController {
  String image;

  @override
  void onInit() {
    super.onInit();
    image = Get.arguments;
  }

  void confirmImage() => Get.back(result: true);
}
