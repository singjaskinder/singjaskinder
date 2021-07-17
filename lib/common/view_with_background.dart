import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';

class BuildViewWithBackground extends StatelessWidget {
  BuildViewWithBackground(
      {Key key,
      this.child,
      this.bottomNavigationBar,
      this.resizeToAvoidBottomInset = false,
      this.haveSafeArea = true,
      this.appBar,
      @required this.hasBackButton,
      @required this.gradient,
      @required this.positionedImage,
      this.actions})
      : super(key: key);

  final Widget child;
  final Widget bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final bool haveSafeArea;
  final bool hasBackButton;
  final Widget appBar;
  final Gradient gradient;
  final Widget positionedImage;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: appBar ??
            AppBar(
                elevation: 0,
                backgroundColor: AppColors.transparent,
                leading: Visibility(
                  visible: hasBackButton,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FloatingActionButton(
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
                  ),
                ),
                iconTheme:
                    IconTheme.of(context).copyWith(color: AppColors.black),
                actions: actions),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(gradient: gradient),
            ),
            positionedImage,
            Container(
              child: haveSafeArea
                  ? SafeArea(
                      child: child,
                    )
                  : Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).padding.top,
                        ),
                        Expanded(child: child)
                      ],
                    ),
            ),
          ],
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
