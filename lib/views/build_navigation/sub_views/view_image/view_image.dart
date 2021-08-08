import 'dart:io';

import 'package:dlivrDriver/common/curved_body.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'view_image_controller.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ViewImageController());
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.black,
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      body: Center(
          child: PhotoView(
              imageProvider: controller.image.contains('http')
                  ? NetworkImage(controller.image)
                  : FileImage(File(controller.image)))),
    );
  }
}
