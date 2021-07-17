import 'dart:io';

import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/text_field.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:dlivrDriver/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'profile_details_controller.dart';
class ProfileDetails extends StatelessWidget {
const ProfileDetails({Key key}) : super(key: key);

            @override
            Widget build(BuildContext context) {
            final controller = Get.put(ProfileDetailsController());
              return BuildViewWithBackground(
      hasBackButton: true,
      haveSafeArea: false,
      positionedImage: Positioned(
        bottom: 0,
        top: 180,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: 0.8,
            child: Image.asset(
              getImage('bg_main2.png'),
            ),
          ),
        ),
      ),
      gradient: AppStyles.lightGradient,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BuildSizedBox(),
              Align(
                alignment: Alignment.topCenter,
                child: BuildText(
                  'My Profile',
                  size: 3.5,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              BuildSizedBox(),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() => BuildUserImage(
                          imageData: controller
                              .buildNavigationController.imageUrl.value,
                          onTap: () => controller.imageControl(),
                          fromNetwork: controller.fromNetwork.value,
                        )),
                    BuildSizedBox(height: 2),
                    BuildCustomTextField(
                      controller: controller.nameCtrl,
                      textInputType: TextInputType.emailAddress,
                      hint: 'Full Name',
                      prefixIcon: Icon(Feather.user),
                      validator: (val) => Validation.validateName(val),
                    ),
                    BuildSizedBox(
                      height: 1.5,
                    ),
                    BuildCustomTextField(
                      toEnabled: false,
                      controller: controller.emailCtrl,
                      textInputType: TextInputType.emailAddress,
                      hint: 'Email Address',
                      prefixIcon: Icon(Feather.mail),
                      validator: (val) => Validation.validateEmail(val),
                    ),
                    BuildSizedBox(
                      height: 1.5,
                    ),
                    BuildCustomTextField(
                      toEnabled: false,
                      controller: controller.phoneCtrl,
                      textInputType: TextInputType.phone,
                      hint: 'Phone',
                      prefixIcon: Icon(Feather.phone),
                      maxLength: 10,
                      validator: (val) => Validation.validatePhone(val),
                    ),
                    BuildSizedBox(
                      height: 1.5,
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Obx(
                          () => BuildSecondaryButton(
                            onTap: () => controller.toAddAddress(),
                            label: controller.address.value.isEmpty
                                ? 'Add Address +'
                                : 'Edit Address',
                          ),
                        )),
                    BuildSizedBox(),
                    Obx(
                      () => controller.address.value.isEmpty
                          ? SizedBox()
                          : Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  boxShadow: [AppStyles.tileShadow]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BuildText(
                                    controller.getAddress().address,
                                    color: AppColors.medViolet,
                                    fontWeight: FontWeight.bold,
                                    size: 2.6,
                                  ),
                                  BuildText(
                                    controller
                                        .getAddress()
                                        .postalCode
                                        .toString(),
                                    color: AppColors.darkViolet,
                                    fontWeight: FontWeight.bold,
                                    size: 2.2,
                                  ),
                                  Row(
                                    children: [
                                      BuildText(
                                        controller.getAddress().state +
                                            ' - ' +
                                            controller.getAddress().city,
                                        color: AppColors.darkViolet,
                                      ),
                                    ],
                                  )
                                ],
                              )),
                    ),
                    BuildSizedBox(
                      height: 3,
                    ),
                    BuildPrimaryButton(
                        onTap: () => controller.updateDetails(),
                        label: 'Update')
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildUserImage extends StatelessWidget {
  const BuildUserImage(
      {@required this.onTap,
      @required this.imageData,
      @required this.fromNetwork,
      Key key})
      : super(key: key);
  final dynamic imageData;
  final Function onTap;
  final bool fromNetwork;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 18,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: SizeConfig.widthMultiplier * 30,
                height: SizeConfig.heightMultiplier * 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: Offset(0, -2))
                    ])),
          ),
          Center(
            child: CircleAvatar(
              radius: SizeConfig.imageSizeMultiplier * 20,
              backgroundColor: AppColors.white,
            ),
          ),
          imageData.isEmpty
              ? Center(
                  child: CircleAvatar(
                    radius: SizeConfig.imageSizeMultiplier * 18,
                    backgroundColor: AppColors.violet.withOpacity(0.4),
                    child: Icon(Feather.user, color: AppColors.violet),
                  ),
                )
              : fromNetwork
                  ? Center(
                      child: CircleAvatar(
                        radius: SizeConfig.imageSizeMultiplier * 18,
                        backgroundImage: NetworkImage(imageData),
                      ),
                    )
                  : Center(
                      child: CircleAvatar(
                        radius: SizeConfig.imageSizeMultiplier * 18,
                        backgroundColor: AppColors.violet.withOpacity(0.4),
                        backgroundImage: FileImage(File(imageData)),
                      ),
                    ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding:
                    EdgeInsets.only(right: SizeConfig.widthMultiplier * 30),
                child: FloatingActionButton(
                  heroTag: 'profile',
                  onPressed: onTap,
                  backgroundColor: AppColors.medViolet,
                  child: Icon(imageData.isEmpty ? Feather.camera : Icons.close,
                      color: AppColors.white),
                ),
              ))
        ],
      ),
    );
  }
}
