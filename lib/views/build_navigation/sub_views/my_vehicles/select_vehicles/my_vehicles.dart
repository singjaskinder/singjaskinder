import 'package:cached_network_image/cached_network_image.dart';
import 'package:dlivrDriver/common/build_circular_loading.dart';
import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/retry.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/models/api_response/my_vehicle_m.dart';
import 'package:dlivrDriver/models/api_response/notification_m.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_vehicles_controller.dart';

class MyVehicles extends StatelessWidget {
  const MyVehicles({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyVehiclesController());
    return BuildViewWithBackground(
      hasBackButton: true,
      haveSafeArea: false,
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
              'My Vehicles',
              size: 3.5,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          BuildSizedBox(),
          Expanded(
            child: GetBuilder<MyVehiclesController>(
              builder: (controller) {
                return FutureBuilder<List<MyVehiclesM>>(
                    future: controller.getVehicles(),
                    builder: (_, snap) {
                      if (snap.hasData) {
                        if (snap.data.isEmpty) {
                          return Center(
                              child: BuildText('No vehciles added',
                                  color: AppColors.white,
                                  fontFamily: AppStyles.robotoB));
                        }

                        return ListView.separated(
                            itemCount: snap.data.length,
                            padding: EdgeInsets.zero,
                            separatorBuilder: (_, i) {
                              return SizedBox(
                                height: SizeConfig.heightMultiplier,
                              );
                            },
                            itemBuilder: (_, i) {
                              final myVehicle = snap.data[i];

                              return BuildMyVehicleTile(myVehicle,
                                  onTap: () =>
                                      controller.toAUVehicle(myVehicle));
                            });
                      } else if (snap.hasError) {
                        print(snap.error);
                        return Center(
                            child:
                                BuildRetry(onRetry: () => controller.update()));
                      } else {
                        return BuildCircularLoading();
                      }
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: BuildPrimaryButton(
                onTap: () => controller.toSelectVehicle(),
                label: 'Add Vehicle +'),
          )
        ],
      ),
    );
  }
}

class BuildMyVehicleTile extends StatelessWidget {
  const BuildMyVehicleTile(this.myVehicle, {this.onTap, Key key})
      : super(key: key);
  final MyVehiclesM myVehicle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [AppStyles.tileShadow]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: BuildText(
                makeDateTime(myVehicle.createdAt),
                color: AppColors.darkViolet,
                size: 1.6,
              ),
            ),
            Row(
              children: [
                CachedNetworkImage(
                  placeholder: (_, v) => BuildCircularLoading(),
                  imageUrl: makeImageLink(myVehicle.vehicleImage),
                  width: SizeConfig.imageSizeMultiplier * 25,
                  height: SizeConfig.imageSizeMultiplier * 25,
                  fit: BoxFit.cover,
                ),
                BuildSizedBox(
                  width: 3,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildText(
                      myVehicle.name,
                      color: AppColors.darkViolet,
                      fontWeight: FontWeight.bold,
                      size: 2.8,
                    ),
                    BuildText(
                      myVehicle.color,
                      color: AppColors.darkViolet,
                      fontWeight: FontWeight.bold,
                    ),
                    BuildText(
                      myVehicle.type,
                      color: AppColors.darkViolet,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
