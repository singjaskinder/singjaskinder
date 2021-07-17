import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildDialog {
  BuildDialog(String title, String text, String posLabel, String negLabel,
      Function onPos, Function onNeg) {
    Get.dialog(
        Scaffold(
            backgroundColor: AppColors.transparent,
            body: Center(
              child: Container(
                width: SizeConfig.widthMultiplier * 80,
                padding: EdgeInsets.all(15),
                color: AppColors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildText(title ?? 'Oops',
                        size: 3, fontWeight: FontWeight.bold),
                    BuildSizedBox(),
                    BuildText(
                      text ?? 'Something went wrong ...',
                      size: 2,
                    ),
                    BuildSizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                            visible: negLabel != null,
                            child: BuildSecondaryButton(
                              onTap: () => onNeg == null ? Get.back() : onNeg(),
                              label: negLabel ?? '',
                            )),
                        BuildSizedBox(),
                        BuildSecondaryButton(
                          onTap: () => onPos == null ? Get.back() : onPos(),
                          label: posLabel ?? 'OK',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
        barrierDismissible: false);
  }
}
