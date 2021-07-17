import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_vehicles_controller.dart';
class MyVehicles extends StatelessWidget {
const MyVehicles({Key key}) : super(key: key);

            @override
            Widget build(BuildContext context) {
            final controller = Get.put(MyVehiclesController());
            return Scaffold();
           }
        }