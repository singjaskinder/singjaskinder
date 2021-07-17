import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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

import 'add_address_controller.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddAddressController());
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
                  'My Address',
                  size: 3.5,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              BuildSizedBox(
                height: 3,
              ),
              BuildCustomTextField(
                controller: controller.stateCtrl,
                textInputType: TextInputType.name,
                hint: 'State',
                prefixIcon: Icon(Feather.map),
                validator: (val) =>
                    Validation.validateField(val, 'Please enter valid state'),
              ),
              BuildSizedBox(
                height: 1.5,
              ),
              BuildCustomTextField(
                controller: controller.cityCtrl,
                textInputType: TextInputType.name,
                hint: 'City',
                prefixIcon: Icon(Feather.map_pin),
                validator: (val) =>
                    Validation.validateField(val, 'Please enter valid city'),
              ),
              BuildSizedBox(
                height: 1.5,
              ),
              BuildCustomTextField(
                controller: controller.addressCtrl,
                textInputType: TextInputType.streetAddress,
                hint: 'Block No. / Building / Plot',
                prefixIcon: Icon(Feather.map_pin),
                validator: (val) =>
                    Validation.validateField(val, 'Please enter valid address'),
              ),
              BuildSizedBox(
                height: 1.5,
              ),
              BuildCustomTextField(
                controller: controller.postalCtrl,
                textInputType: TextInputType.number,
                hint: 'Postal Code',
                prefixIcon: Icon(Feather.hash),
                maxLength: 8,
                validator: (val) => Validation.validateField(
                    val, 'Please enter valid postal code',
                    isNum: true, minlength: 6),
              ),
              BuildSizedBox(
                height: 1.5,
              ),
              Spacer(),
              BuildPrimaryButton(
                  onTap: () => controller.updateAddress(),
                  label:
                      (controller.profileDetailsController.address.value.isEmpty
                              ? 'Add'
                              : 'Update') +
                          ' Address'),
              BuildSizedBox(
                height: 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
