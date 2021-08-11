import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/my_vehicle_m.dart';
import 'package:dlivrDriver/models/api_response/vehicle_m.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_vehicles/select_vehicles/my_vehicles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyVehiclesController extends GetxController {
  final double runSpacing = 8;
  final double spacing = 8;
  final columns = 2;
  double width;
  List<MyVehiclesM> myVehicles = [];
  List<Vehicles> vehicles = [];

  Future<List<MyVehiclesM>> getVehicles() async {
    final res = await ApiHandler.getHttp(EndPoints.getVehicles);
    return MyVehicleM.fromJson(res.data).myVehiclesM;
  }

  void toAUVehicle(Vehicles vehicle) {
    MyVehiclesM myVehicleM;
    if (vehicle.updatedAt.isEmpty) {
      for (Vehicles vehicle in vehicles) {
        for (MyVehiclesM myVehicle in myVehicles) {
          if (vehicle.name == myVehicle.type) {
            myVehicleM = myVehicle;
            break;
          }
        }
      }
      print(myVehicleM.toJson());
      print('----------');
      Get.toNamed(Routes.auVehicle,
          arguments: {'new': false, 'value': myVehicleM});
    } else {
      Get.toNamed(Routes.auVehicle,
          arguments: {'new': true, 'value': vehicle.name});
    }
  }

  void toSelectVehicle() {
    Get.toNamed(Routes.selectVehicle);
  }

  Future<List<Vehicles>> getVehiclesCategory() async {
    List<Vehicles> vehicles = [];
    final res = await ApiHandler.getHttp(EndPoints.getVehicleCategory);
    vehicles = VehicleM.fromJson(res.data).vehicles;
    final res2 = await ApiHandler.getHttp(EndPoints.getVehicles);
    myVehicles = MyVehicleM.fromJson(res2.data).myVehiclesM;
    for (Vehicles vehicle in vehicles) {
      for (MyVehiclesM myVehicle in myVehicles) {
        if (vehicle.name == myVehicle.type) {
          vehicle.image = myVehicle.vehicleImage;
          vehicle.updatedAt = '';
        }
      }
    }
    this.vehicles = vehicles;
    return vehicles;
  }

  double getWidth() {
    return width =
        (MediaQuery.of(Get.context).size.width - runSpacing * (columns - 1)) /
            columns;
  }
}
