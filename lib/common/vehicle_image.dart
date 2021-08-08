import 'dart:io';

import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BuildVehicleImage extends StatelessWidget {
  const BuildVehicleImage(
      {this.onTap, @required this.imageData, this.largeCircle = false, Key key})
      : super(key: key);
  final String imageData;
  final bool largeCircle;
  final Function onTap;
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
              radius: SizeConfig.imageSizeMultiplier * (largeCircle ? 20 : 17),
              backgroundColor: AppColors.white,
            ),
          ),
          imageData == ''
              ? Center(
                  child: CircleAvatar(
                    radius: SizeConfig.imageSizeMultiplier *
                        (largeCircle ? 17 : 15),
                    backgroundColor: AppColors.violet.withOpacity(0.4),
                    child: Icon(Feather.truck, color: AppColors.violet),
                  ),
                )
              : imageData.contains('http')
                  ? Center(
                      child: CircleAvatar(
                        radius: SizeConfig.imageSizeMultiplier *
                            (largeCircle ? 17 : 15),
                        backgroundImage: NetworkImage(imageData),
                        backgroundColor: AppColors.violet.withOpacity(0.4),
                      ),
                    )
                  : Center(
                      child: CircleAvatar(
                      radius: SizeConfig.imageSizeMultiplier *
                          (largeCircle ? 17 : 15),
                      backgroundImage: FileImage(File(imageData)),
                      backgroundColor: AppColors.violet.withOpacity(0.4),
                    )),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding:
                    EdgeInsets.only(right: SizeConfig.widthMultiplier * 30),
                child: FloatingActionButton(
                  heroTag: 'vehicle',
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
