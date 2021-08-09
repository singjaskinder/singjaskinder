import 'dart:async';
import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/job_m.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  Future<List<Jobs>> getJobs() async {
    try {
      final location = await getLocation();
      final res = await ApiHandler.getHttp(EndPoints.getNearbyJobs,
          params: location.latitude.toString() +
              '/' +
              location.longitude.toString());
      return JobM.fromJson(res.data).jobs;
      // return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  void toJobDetails(Jobs job) {
    Get.toNamed(Routes.jobDetails, arguments: {'job_details': job});
  }

  Future<LatLng> getLocation() async {
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
    LocationData locationData = await location.getLocation();
    return LatLng(locationData.latitude, locationData.longitude);
  }
}
