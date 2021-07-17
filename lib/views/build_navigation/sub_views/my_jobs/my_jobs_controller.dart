import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/job_m.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:get/get.dart';

class MyJobsController extends GetxController {
  Future<List<Jobs>> getJobs() async {
    final res = await ApiHandler.getHttp(EndPoints.getBiddedJobs);
    return JobM.fromJson(res.data).jobs;
  }

  void toJobDetails(Jobs job) =>
      Get.toNamed(Routes.jobDetails, arguments: {'job_details': job});
}
