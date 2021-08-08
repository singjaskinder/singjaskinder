import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/job_m.dart';
import 'package:get/get.dart';

class CompletedJobsController extends GetxController {
  Future<List<Jobs>> getJobs() async {
    final res =
        await ApiHandler.getHttp(EndPoints.getJobs, params: 'completed');
    return JobM.fromJson(res.data).jobs;
  }
}
