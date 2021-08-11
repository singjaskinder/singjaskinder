import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class DocumentM {
  DocumentM({this.label, this.imageData});
  String imageData;
  String label;
}

class BuildSection extends StatelessWidget {
  const BuildSection(this.label, {Key key}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.widthMultiplier * 80,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.medViolet,
          borderRadius: BorderRadius.horizontal(right: Radius.circular(50)),
          boxShadow: [AppStyles.tileShadowDark]),
      child: Row(
        children: [
          BuildSizedBox(
            width: 2,
          ),
          BuildText(
            label.capitalize,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            size: 2.6,
          ),
          Spacer(),
          CircleAvatar(
            backgroundColor: AppColors.white,
            child: Icon(
              Icons.arrow_circle_down,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class BuildDocumentTile extends StatelessWidget {
  const BuildDocumentTile(this.document, {this.onTap, Key key})
      : super(key: key);
  final DocumentM document;
  final Function(bool remove) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [AppStyles.tileShadowDark]),
      child: Row(
        children: [
          Icon(
            Feather.file,
            color: AppColors.violet,
            size: SizeConfig.imageSizeMultiplier * 5,
          ),
          BuildSizedBox(
            width: 2,
          ),
          BuildText(
            document.label.replaceAll('_', ' ').capitalize,
            color: AppColors.darkViolet,
            size: 2,
          ),
          Spacer(),
          GestureDetector(
            onTap: () => onTap(false),
            child: Icon(
              document.imageData.isEmpty ? Icons.open_in_new : Feather.eye,
              color: AppColors.violet,
              size: SizeConfig.imageSizeMultiplier * 5,
            ),
          ),
          BuildSizedBox(
            width: 3,
          ),
          Visibility(
            visible: document.imageData.isNotEmpty,
            child: GestureDetector(
              onTap: () => onTap(true),
              child: Icon(
                Feather.x,
                color: AppColors.violet,
                size: SizeConfig.imageSizeMultiplier * 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
