import 'package:get/get.dart';

import '../home_controller.dart';

class JobAddedDetailsController extends GetxController {
  HomeController homeController = Get.find();

  void onDone() {
    homeController.changePage(1);
    homeController.clearData();
    Get.back();
  }
}
