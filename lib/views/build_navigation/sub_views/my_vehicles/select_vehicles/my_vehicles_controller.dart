import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/my_vehicle_m.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_vehicles/select_vehicles/my_vehicles.dart';
import 'package:get/get.dart';

class MyVehiclesController extends GetxController {
  Future<List<MyVehiclesM>> getVehicles() async {
    final res = await ApiHandler.getHttp(EndPoints.getVehicles);
    return MyVehicleM.fromJson(res.data).myVehiclesM;
  }

  void toAUVehicle(MyVehiclesM myVehicle) {
    Get.toNamed(Routes.auVehicle, arguments: {'new': false, 'value': myVehicle});
  }

  void toSelectVehicle() {
    Get.toNamed(Routes.selectVehicle);
  }
}
