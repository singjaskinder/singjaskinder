import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/vehicle_m.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:get/get.dart';

class SelectVehiclesController extends GetxController {
  final vehicle = Vehicles().obs;

  @override
  void onInit() {
    super.onInit();
    vehicle.value = null;
  }

  Future<List<Vehicles>> getVehicles() async {
    final res = await ApiHandler.getHttp(EndPoints.getVehicleCategory);
    return VehicleM.fromJson(res.data).vehicles;
  }

  void toAUVehicle() {
    Get.toNamed(Routes.auVehicle,
        arguments: {'new': true, 'value': vehicle.value.name});
  }
}
