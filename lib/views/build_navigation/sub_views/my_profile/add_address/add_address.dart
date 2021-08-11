import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/text_field.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
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
                controller: controller.addressCtrl,
                textInputType: TextInputType.streetAddress,
                hint: 'Apartment / Unit No.',
                prefixIcon: Icon(Icons.location_city_outlined),
                validator: (val) =>
                    Validation.validateField(val, 'Please enter valid Address'),
              ),
              BuildSizedBox(
                height: 1.5,
              ),
              BuildCustomTextField(
                controller: controller.streetCtrl,
                textInputType: TextInputType.name,
                hint: 'Street',
                prefixIcon: Icon(Icons.location_on_outlined),
                validator: (val) =>
                    Validation.validateField(val, 'Please enter valid Street'),
              ),
              BuildSizedBox(
                height: 1.5,
              ),
              BuildCustomTextField(
                controller: controller.suburbCtrl,
                textInputType: TextInputType.name,
                hint: 'Suburb',
                prefixIcon: Icon(Feather.map),
                validator: (val) =>
                    Validation.validateField(val, 'Please enter valid Suburb'),
              ),
              BuildSizedBox(
                height: 1.5,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [AppStyles.tileShadow],
                ),
                child: Obx(() => DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox(),
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const BuildText(
                        'Select State',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    icon: CircleAvatar(
                      backgroundColor: AppColors.medViolet,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.white,
                      ),
                    ),
                    items: controller.states.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: BuildText(
                            value,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }).toList(),
                    value: controller.selectedState.value,
                    onChanged: (val) => controller.selectedState.value = val)),
              ),
              BuildSizedBox(
                height: 1.5,
              ),
              BuildCustomTextField(
                controller: controller.postalCtrl,
                textInputType: TextInputType.number,
                hint: 'Post Code',
                prefixIcon: Icon(Feather.hash),
                maxLength: 4,
                validator: (val) => Validation.validateField(
                    val, 'Please enter valid  4-digit Post Code',
                    isNum: true, minlength: 4),
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
