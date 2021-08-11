import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/job_m.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:get/get.dart';

class InprogressJobsController extends GetxController {
  bool inProgressJob = false;
  Future<List<Jobs>> getJobs() async {
    List<Jobs> jobs = [];
    final res = await ApiHandler.getHttp(EndPoints.getJobs, params: 'upcoming');
    final res1 =
        await ApiHandler.getHttp(EndPoints.getJobs, params: 'inprogress');
    List<Jobs> inProgressJobs = JobM.fromJson(res1.data).jobs;
    jobs.addAll(JobM.fromJson(res.data).jobs);
    jobs.addAll(inProgressJobs);
    inProgressJob = inProgressJobs.isNotEmpty;
    return jobs;
  }

  void toInprogressJobDetails(Jobs job) {
    Get.toNamed(Routes.inprogressJobDetails, arguments: {'job_details': job});
  }
}
