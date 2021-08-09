import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/job_m.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/functions/preferences.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/inprogress_jobs/inprogress_jobs_controller.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InprogressJobDetailsController extends GetxController {
  Jobs job;
  Completer<GoogleMapController> mapController = Completer();
  final polylines = Set<Polyline>().obs;
  CameraPosition initialPos;
  LatLng sourceLocation;
  LatLng destinationLocation;
  double biddedprice = 0.0;
  final isRateDone = false.obs;
  final isComplete = false.obs;
  final status = 'upcoming'.obs;
  String id;

  @override
  void onInit() {
    super.onInit();
    id = Preferences.getId();
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
    status.value = job.status;
    for (Bidding bidding in job.bidding) {
      if (bidding.driverId == id) {
        biddedprice = bidding.bid;
      }
    }
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

  bool rateBtnEnable() {
    if (!isRateDone.value && status.value == 'completed') {
      return true;
    } else {
      return false;
    }
  }

  void decide() async {
    if (1 == 1) {}
    try {
      isLoading(true);
      await ApiHandler.putHttp(
        status.value == 'upcoming'
            ? EndPoints.putJobProgress
            : EndPoints.putJobCompleted,
        null,
        params: job.sId,
      );
      isLoading(false);
      BuildRetryBottomSheet(Get.context, null,
          text: 'Job ' +
              (status.value == 'upcoming' ? 'started' : 'completed') +
              ' successfully',
          label: 'OK',
          errored: false,
          done: true,
          cancellable: false);
      if (status.value == 'upcoming') {
        status.value = 'inprogress';
      } else if (status.value == 'inprogress') {
        status.value = 'completed';
        InprogressJobsController inprogressJobsController = Get.find();
        inprogressJobsController.update();
      }
    } on DioError catch (e) {
      print(e);
      isLoading(false);
      BuildRetryBottomSheet(Get.context, decide,
          errored: true, autoClose: true, cancellable: false);
    }
  }

  void toCall() async {
    final String url = 'tel:' + job.userId.phone;
    await launch(url);
  }

  void toRate() async {
    final res =
        await Get.toNamed(Routes.addRating, arguments: {'job_details': job});
    if (res != null) {
      BuildRetryBottomSheet(Get.context, () {
        isRateDone.value = true;
      },
          text: 'Rating submitted for user',
          label: 'OK',
          done: true,
          errored: false,
          cancellable: false);
    }
  }

  void toDriverChat() =>
      Get.toNamed(Routes.driverChat, arguments: {'job_details': job});
}
