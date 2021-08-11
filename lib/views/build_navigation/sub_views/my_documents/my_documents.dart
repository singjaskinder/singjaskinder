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
                        return BuildDocWrapper(i, doc,
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

class BuildDocWrapper extends StatelessWidget {
  const BuildDocWrapper(this.index, this.document, {this.onTap, Key key})
      : super(key: key);
  final int index;
  final DocumentM document;
  final Function onTap;

  bool getVisibility() {
    if (index == 0 || index == 2 || index == 7 || index == 8) {
      return true;
    }
    return false;
  }

  String getLabel() {
    if (index == 0) {
      return 'primary documents';
    } else if (index == 2) {
      return 'secondary documents';
    } else if (index == 7) {
      return 'required documents';
    } else if (index == 8) {
      return 'become super driver';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: getVisibility(),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: BuildSection(getLabel()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: BuildDocumentTile(
              document,
              onTap: onTap,
            ),
          )
        ],
      ),
    );
  }
}
