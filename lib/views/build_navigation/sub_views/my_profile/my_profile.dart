import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dlivrDriver/common/build_circular_loading.dart';
import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/curved_body.dart';
import 'package:dlivrDriver/common/retry.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/text_field.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/models/api_response/user_m.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:dlivrDriver/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'my_profile_controller.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyProfileController());
    return BuildViewWithBackground(
      hasBackButton: true,
      haveSafeArea: false,
      positionedImage: Positioned(
        bottom: 40,
        top: 200,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: 0.8,
            child: Image.asset(
              getImage('bg_main0.png'),
            ),
          ),
        ),
      ),
      gradient: AppStyles.lightGradient,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        BuildSizedBox(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: BuildText(
            'Profile',
            size: 3.5,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        BuildSizedBox(
          height: 3,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: BuildPrimaryButton(
              onTap: () => controller.toProfileDetails(),
              label: 'Profile details'),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: BuildPrimaryButton(
              onTap: () => controller.toSetPin(), label: 'Set / update pin'),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: BuildPrimaryButton(
              onTap: () => controller.toUpdatePassword(),
              label: 'Change password'),
        ),
      ]),
    );
  }
}
