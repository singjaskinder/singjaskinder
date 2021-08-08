import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/document_tile.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_documents_controller.dart';

class MyDocuments extends StatelessWidget {
  const MyDocuments({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyDocumentsController());
    return BuildViewWithBackground(
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
              ' My Documents',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildSizedBox(),
                  GetBuilder<MyDocumentsController>(
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
                ],
              ),
            ),
          )),
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: BuildPrimaryButton(
                onTap: () => controller.updateDocuments(),
                label: 'Submit',
              ))
        ],
      ),
    );
  }
}
