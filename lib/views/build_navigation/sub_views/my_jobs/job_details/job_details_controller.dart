import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/bidding_m.dart';
import 'package:dlivrDriver/models/api_response/job_m.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/functions/preferences.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/home/home_controller.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_jobs/my_jobs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class JobDetailsController extends GetxController {
  Jobs job;
  Completer<GoogleMapController> mapController = Completer();
  final polylines = Set<Polyline>().obs;
  final markers = Set<Marker>().obs;
  BitmapDescriptor startIcon;
  BitmapDescriptor endIcon;
  CameraPosition initialPos;
  LatLng sourceLocation;
  LatLng destinationLocation;
  final bidCount = 0.obs;
  final bidPrice = (0.0).obs;
  Bidding biddingDetails;
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
    for (Bidding bidding in job.bidding) {
      if (bidding.driverId == id) {
        bidCount.value = bidding.count;
        bidPrice.value = bidding.bid;
        biddingDetails = bidding;
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
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(10, 10)),
            'assets/images/markers/start.png')
        .then((icon) {
      startIcon = icon;
    });
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(10, 10)),
            'assets/images/markers/end.png')
        .then((icon) {
      endIcon = icon;
    });
    markers.add(Marker(
        markerId: MarkerId('scr1'), position: sourceLocation, icon: startIcon));
    markers.add(Marker(
        markerId: MarkerId('des1'),
        position: destinationLocation,
        icon: endIcon));

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

  void toBidprice() {
    if (!checkProfileDetails()) {
      return;
    }
    if (!checkDocuments()) {
      return;
    }
    Get.toNamed(Routes.bidPrice,
        arguments: {'job_details': job, 'bidding_details': biddingDetails});
  }
}
