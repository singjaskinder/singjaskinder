import 'dart:async';

import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/job_m.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/home/home_controller.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_jobs/my_jobs_controller.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class JobDetailsController extends GetxController {
  Jobs job;
  Completer<GoogleMapController> mapController = Completer();
  final polylines = Set<Polyline>().obs;
  CameraPosition initialPos;
  LatLng sourceLocation;
  LatLng destinationLocation;

  @override
  void onInit() {
    super.onInit();
    final res = Get.arguments;
    job = res['job_details'];
    sourceLocation = LatLng(
        job.pickLocation.coordinates[0], job.pickLocation.coordinates[1]);
    destinationLocation = LatLng(
        job.dropLocation.coordinates[0], job.dropLocation.coordinates[1]);
    initialPos = CameraPosition(
      target: sourceLocation,
      zoom: 14,
    );
  }

  @override
  void onReady() {
    super.onReady();
    getPlotDetails();
  }

  Future<void> getPlotDetails() async {
    PolylinePoints polylinePoints = PolylinePoints();
    isLoading(true);
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyAXUZJV__NaYwjpvaMjAfZgZ4AqfaG5gww',
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );
    List<LatLng> polylineCoordinates = [];
    result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
    Map<PolylineId, Polyline> polyLines = {};
    final id = PolylineId('poly');
    Polyline polyline = Polyline(
        polylineId: id,
        color: AppColors.medViolet,
        width: 5,
        points: polylineCoordinates);
    polyLines[id] = polyline;
    polylines.clear();
    isLoading(false);
    this.polylines.addAll(polyLines.values);
    LatLng tempLocation;
    if (destinationLocation.latitude > sourceLocation.latitude) {
      tempLocation = sourceLocation;
      sourceLocation = destinationLocation;
      destinationLocation = tempLocation;
    }

    final GoogleMapController mapController1 = await mapController.future;
    mapController1.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: destinationLocation,
          northeast: sourceLocation,
        ),
        11.0,
      ),
    );
  }

  void confirmJobClose() async {
    BuildRetryBottomSheet(Get.context, closeJob,
        text: 'Are you sure you want to close this job?',
        label: 'Yes',
        errored: false,
        cancellable: true);
  }

  void closeJob() async {
    try {
      isLoading(true);
      await ApiHandler.putHttp(EndPoints.putJobCancel, null, params: job.sId);
      MyJobsController myJobsController = Get.find();
      myJobsController.update();
      isLoading(false);
      BuildRetryBottomSheet(Get.context, Get.back,
          text: 'This Job has being closed',
          label: 'OK',
          done: true,
          errored: false,
          cancellable: false);
    } catch (e) {
      print(e);
      isLoading(false);
      BuildRetryBottomSheet(Get.context, closeJob,
          errored: true, cancellable: true, autoClose: true);
    }
  }

  void toDecideWay() {
    if (job.status.toLowerCase() == 'upcoming') {
      toAssignDriverDetails();
    } else {
      toBidding();
    }
  }

  bool enableButton() {
    if (job.status.toLowerCase() == 'upcoming') {
      return false;
    } else if (job.status.toLowerCase() == 'cancelled') {
      return false;
    } else
      return true;
  }

  void toBidding() {}

  void toAssignDriverDetails() {}
}
