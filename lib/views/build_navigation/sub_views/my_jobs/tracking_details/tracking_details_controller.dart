import 'dart:async';

import 'package:dlivrDriver/models/api_response/job_m.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingDetailsController extends GetxController {
  Jobs job;
  Completer<GoogleMapController> mapController = Completer();
  final rateFormKey = GlobalKey<FormState>();
  final polylines = Set<Polyline>().obs;
  CameraPosition initialPos;
  LatLng sourceLocation;
  LatLng destinationLocation;
  String image;
  final reviewCtrl = TextEditingController();
  final isTipAdded = false.obs;
  final isRateDone = false.obs;
  @override
  void onInit() {
    super.onInit();
    final res = Get.arguments;
    job = res['job_details'];
    image = job.userId.profileImage == null
        ? ''
        : makeImageLink(job.userId.profileImage);
    sourceLocation = LatLng(
        job.pickLocation.coordinates[0], job.pickLocation.coordinates[1]);
    destinationLocation = LatLng(
        job.dropLocation.coordinates[0], job.dropLocation.coordinates[1]);
    initialPos = CameraPosition(
      target: sourceLocation,
      zoom: 14,
    );
    if (job.status == 'completed') {
      isTipAdded.value = true;
      isRateDone.value = true;
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

  void toRateDriver() async {
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

  void toAddTip() async {}
}
