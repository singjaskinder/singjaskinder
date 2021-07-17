import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'landing_controller.dart';

import '../../utils/local.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(LandingController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(getImage('landing.png')), fit: BoxFit.fill)),
      ),
    );
  }
}
