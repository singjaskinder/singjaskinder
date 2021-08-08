import 'package:cached_network_image/cached_network_image.dart';
import 'package:dlivrDriver/common/build_circular_loading.dart';
import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/retry.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/models/api_response/vehicle_m.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'select_vehicles_controller.dart';

class SelectVehicles extends StatelessWidget {
  const SelectVehicles({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectVehiclesController());
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
              'Select Vehicle type',
              size: 3.5,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          BuildSizedBox(),
          Expanded(
            child: GetBuilder<SelectVehiclesController>(
              builder: (controller) {
                return FutureBuilder<List<Vehicles>>(
                    future: controller.getVehicles(),
                    builder: (_, snap) {
                      if (snap.hasData) {
                        if (snap.data.isEmpty) {
                          return Center(
                              child: BuildText('No vehicles type found',
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
                              final vehicle = snap.data[i];
                              return Obx(() => BuildVehicleCatTile(
                                    vehicle,
                                    onTap: () {
                                      controller.vehicle.value = vehicle;
                                    },
                                    isSelected:
                                        controller.vehicle.value == vehicle,
                                  ));
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
            child: Obx(() => BuildPrimaryButton(
                isEnabled: controller.vehicle.value != null,
                onTap: () => controller.toAUVehicle(),
                label: 'Next')),
          )
        ],
      ),
    );
  }
}

class BuildVehicleCatTile extends StatelessWidget {
  const BuildVehicleCatTile(this.vehicle,
      {this.onTap, this.isSelected = false, Key key})
      : super(key: key);
  final Vehicles vehicle;
  final Function onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.lightViolet.withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [AppStyles.tileShadow]),
        child: Row(
          children: [
            CachedNetworkImage(
              placeholder: (_, v) => BuildCircularLoading(),
              imageUrl: makeImageLink(vehicle.image),
              width: SizeConfig.imageSizeMultiplier * 30,
              height: SizeConfig.imageSizeMultiplier * 25,
            ),
            BuildText(
              vehicle.name.capitalize,
              color: AppColors.darkViolet,
              fontWeight: FontWeight.bold,
              size: 3,
            ),
            Spacer(),
            Image.asset(
              getImage((isSelected ? 'done' : 'done_outlined') + '.png'),
              width: SizeConfig.widthMultiplier * 15,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
