import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/document_tile.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/text_field.dart';
import 'package:dlivrDriver/common/vehicle_image.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:dlivrDriver/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'au_vehicle_controller.dart';

class AUVehicle extends StatelessWidget {
  const AUVehicle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AUVehicleController());
    return BuildViewWithBackground(
      actions: [
        Visibility(
          visible: controller.isUpdate.value,
          child: IconButton(
            onPressed: () => controller.removeVehicle(),
            icon: Icon(
              Feather.trash,
              color: AppColors.white,
            ),
          ),
        )
      ],
      hasBackButton: true,
      haveSafeArea: false,
      resizeToAvoidBottomInset: true,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BuildSizedBox(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BuildText(
              (controller.isUpdate.value ? 'Update' : 'Add') +
                  ' Vehicle details',
              size: 3.5,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          BuildSizedBox(),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildSizedBox(),
                    Obx(() => BuildVehicleImage(
                          imageData: controller.image.value,
                          onTap: () => controller.imageControl(),
                          largeCircle: true,
                        )),
                    BuildSizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: BuildText(
                        'Vehicle Documents:',
                        size: 3,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    GetBuilder<AUVehicleController>(
                      builder: (_) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: controller.docs.length,
                          itemBuilder: (_, i) {
                            final doc = controller.docs[i];
                            return BuildDocumentTile(doc,
                                onTap: (v) => controller.docControl(i, v));
                          },
                        );
                      },
                    ),
                    BuildSizedBox(
                      height: 3,
                    ),
                    BuildCustomTextField(
                      controller: controller.nameCtrl,
                      hint: 'Vehicle name',
                      textInputAction: TextInputAction.next,
                      validator: (val) => Validation.validateField(
                          val, 'Please enter valid vehicle name'),
                    ),
                    BuildSizedBox(),
                    BuildCustomTextField(
                      controller: controller.colorCtrl,
                      textInputAction: TextInputAction.next,
                      hint: 'Vehicle color',
                      validator: (val) => Validation.validateField(
                          val, 'Please enter valid vehicle color'),
                    ),
                    BuildSizedBox(),
                    BuildCustomTextField(
                      controller: controller.noCtrl,
                      textInputAction: TextInputAction.next,
                      hint: 'Vehicle number',
                      validator: (val) => Validation.validateField(
                          val, 'Please enter valid vehicle number'),
                    ),
                    BuildSizedBox(),
                    BuildCustomTextField(
                      controller: controller.capacityCtrl,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.number,
                      hint: 'Load capacity',
                      validator: (val) => Validation.validateField(
                          val, 'Please enter valid load capacity'),
                    ),
                    BuildSizedBox(
                      height: 3,
                    ),
                  ],
                ),
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: BuildPrimaryButton(
                onTap: () => controller.auVehicle(),
                label: (controller.isUpdate.value ? 'Update' : 'Add') +
                    ' Vehicle'),
          )
        ],
      ),
    );
  }
}
