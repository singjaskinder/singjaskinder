import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/rating_m.dart';
import 'package:dlivrDriver/views/build_navigation/build_navigation_controller.dart';
import 'package:get/get.dart';

class MyRatingsController extends GetxController {
  BuildNavigationController buildNavigationController = Get.find();
  String imageUrl;
  String userName;
  final isEmpty = true.obs;

  @override
  void onInit() {
    super.onInit();
    imageUrl = buildNavigationController.imageUrl.value ?? '';
    userName = buildNavigationController.userName.value ?? '';
  }

  Future<List<Ratings>> getRatings() async {
    final res = await ApiHandler.getHttp(EndPoints.getReviews);
    return RatingM.fromJson(res.data).ratings;
  }
}
