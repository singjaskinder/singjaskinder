import 'package:cached_network_image/cached_network_image.dart';
import 'package:dlivrDriver/common/user_image.dart';
import 'package:dlivrDriver/overlays/dialog.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import 'build_navigation_controller.dart';
import 'sub_views/home/home.dart';

class BuildNavigation extends StatefulWidget {
  BuildNavigation({Key key}) : super(key: key);

  @override
  _BuildNavigationState createState() => _BuildNavigationState();
}

class _BuildNavigationState extends State<BuildNavigation>
    with SingleTickerProviderStateMixin {
  bool showPicker = false;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BuildNavigationController());
    return WillPopScope(
        onWillPop: () async {
          final onPos = () => SystemNavigator.pop();
          BuildDialog('Confirmation', 'Are you sure want to exit the app?',
              'Yes', 'No', onPos, null);
          return false;
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.transparent,
            centerTitle: true,
            title: BuildText(
              'Home',
              size: 3.5,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          drawer: Container(
            decoration: BoxDecoration(gradient: AppStyles.darkGradient),
            width: SizeConfig.widthMultiplier * 80,
            child: Column(
              children: [
                BuildSizedBox(
                  height: 4,
                ),
                Container(
                  child: Column(
                    children: [
                      Obx(
                        () => BuildUserImage(
                          imageData: controller.imageUrl.value,
                        ),
                      ),
                      Obx(
                        () => BuildText(
                          controller.userName.value ?? 'Hello there!',
                          size: 2.4,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BuildSizedBox(),
                      InkWell(
                        onTap: () => controller.toRatings(),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          width: SizeConfig.widthMultiplier * 50,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              boxShadow: [AppStyles.buttonShadow]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Visibility(
                                  visible: controller.ratings.value.isNotEmpty,
                                  child: Icon(
                                    Icons.star,
                                    color: AppColors.yellow,
                                    size: SizeConfig.imageSizeMultiplier * 8,
                                  ),
                                ),
                              ),
                              BuildSizedBox(
                                width: 2,
                              ),
                              Obx(
                                () => BuildText(
                                  controller.ratings.value.isEmpty
                                      ? 'No ratings'
                                      : controller.ratings.value,
                                  size: 3,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.violet,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BuildSizedBox(
                  width: 2,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.sideNavMenus.length,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    itemBuilder: (_, i) {
                      return Container(
                        margin: EdgeInsets.only(right: 60, bottom: 10),
                        height: SizeConfig.heightMultiplier * 6,
                        child: Material(
                          // color: i == controller.currSideNavIndex.value
                          //     ? AppColors.medViolet
                          //     : AppColors.white,
                          color: AppColors.white,
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.zero, right: Radius.circular(50)),
                          child: InkWell(
                              onTap: () => controller.selectMenu(i),
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.zero,
                                  right: Radius.circular(50)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  BuildSizedBox(
                                    width: 6,
                                  ),
                                  Icon(
                                    controller.sideNavMenus[i].iconData,
                                    color: AppColors.violet,
                                    // color:
                                    //     i == controller.currSideNavIndex.value
                                    //         ? AppColors.white
                                    //         : AppColors.violet,
                                    size: 18,
                                  ),
                                  BuildSizedBox(
                                    width: 3,
                                  ),
                                  BuildText(
                                    controller.sideNavMenus[i].label,
                                    size: 2,
                                    color: AppColors.violet,
                                    // color:
                                    //     i == controller.currSideNavIndex.value
                                    //         ? AppColors.white
                                    //         : AppColors.violet,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          body: Home(),
        ));
  }
}
