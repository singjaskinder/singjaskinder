import 'package:cached_network_image/cached_network_image.dart';
import 'package:dlivrDriver/common/build_circular_loading.dart';
import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/retry.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/models/api_response/my_vehicle_m.dart';
import 'package:dlivrDriver/models/api_response/notification_m.dart';
import 'package:dlivrDriver/models/api_response/vehicle_m.dart';
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
    controller.getWidth();
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BuildSizedBox(
                    height: 2,
                  ),
                  GetBuilder<MyVehiclesController>(
                    builder: (controller) {
                      return FutureBuilder<List<Vehicles>>(
                          future: controller.getVehiclesCategory(),
                          builder: (_, snap) {
                            if (snap.hasData) {
                              if (snap.data.isEmpty) {
                                return Center(
                                    child: BuildText('No vehicles added',
                                        color: AppColors.white,
                                        fontFamily: AppStyles.robotoB));
                              }
                              return Wrap(
                                runSpacing: controller.runSpacing,
                                spacing: controller.spacing,
                                alignment: WrapAlignment.center,
                                children: snap.data.map((vehicle) {
                                  return BuildVehicleCatTile(
                                    vehicle,
                                    onTap: () => controller.toAUVehicle(vehicle),
                                    width: controller.width,
                                  );
                                }).toList(),
                              );
                            } else if (snap.hasError) {
                              print(snap.error);
                              return Center(
                                  child: BuildRetry(
                                      onRetry: () => controller.update()));
                            } else {
                              return Center(
                                  heightFactor: 3.5,
                                  child: BuildCircularLoading());
                            }
                          });
                    },
                  ),
                  BuildSizedBox(
                    height: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildVehicleCatTile extends StatelessWidget {
  const BuildVehicleCatTile(this.vehicle, {this.onTap, this.width, Key key})
      : super(key: key);
  final Vehicles vehicle;
  final Function onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 15,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.7),
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [AppStyles.tileShadow]),
          child: Column(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(vehicle.updatedAt.isNotEmpty ? 0 : 5),
                child: CachedNetworkImage(
                  placeholder: (_, v) => BuildCircularLoading(),
                  imageUrl: makeImageLink(vehicle.image),
                  color:
                      vehicle.updatedAt.isNotEmpty ? AppColors.medViolet : null,
                  width: vehicle.updatedAt.isNotEmpty
                      ? null
                      : SizeConfig.imageSizeMultiplier * 25,
                  height: SizeConfig.imageSizeMultiplier * 25,
                  fit: vehicle.updatedAt.isNotEmpty ? null : BoxFit.cover,
                ),
              ),
              BuildSizedBox(),
              BuildText(
                vehicle.name.capitalize,
                color: AppColors.medViolet,
                fontWeight: FontWeight.bold,
                size: 2.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
