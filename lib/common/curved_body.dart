import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildCurvedBody extends StatelessWidget {
  const BuildCurvedBody(
      {@required this.title, @required this.children, Key key})
      : super(key: key);
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppStyles.darkGradient),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Column(
          children: [
            SafeArea(
              child: Container(
                height: SizeConfig.heightMultiplier * 8,
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      backgroundColor: AppColors.medViolet,
                      onPressed: () => Routes.back(),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.white,
                          size: SizeConfig.imageSizeMultiplier * 5,
                        ),
                      ),
                    ),
                    Spacer(),
                    BuildText(
                      title.capitalize,
                      size: 3.2,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                child: Column(
                  children: children,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
