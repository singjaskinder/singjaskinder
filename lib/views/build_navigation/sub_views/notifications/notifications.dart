import 'package:dlivrDriver/common/build_circular_loading.dart';
import 'package:dlivrDriver/common/retry.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/models/api_response/notification_m.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'notifications_controller.dart';

class ViewNotifications extends StatelessWidget {
  const ViewNotifications({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());
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
              'Notifications',
              size: 3.5,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          BuildSizedBox(),
          Expanded(
            child: GetBuilder<NotificationsController>(
              builder: (controller) {
                return FutureBuilder<List<Notifications>>(
                    future: controller.getNotifications(),
                    builder: (_, snap) {
                      if (snap.hasData) {
                        if (snap.data.isEmpty) {
                          return Center(
                              child: BuildText('No Notifications',
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
                              final notification = snap.data[i];
                              return BuildNotificationTile(
                                notification,
                              );
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
          )
        ],
      ),
    );
  }
}

class BuildNotificationTile extends StatelessWidget {
  const BuildNotificationTile(this.notification, {Key key}) : super(key: key);
  final Notifications notification;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              makeDateTime(notification.createdAt),
              color: AppColors.darkViolet,
              fontWeight: FontWeight.bold,
              size: 1.6,
            ),
          ),
          BuildSizedBox(),
          BuildText(
            notification.title ?? '',
            color: AppColors.darkViolet,
            fontWeight: FontWeight.bold,
            size: 2.4,
          ),
          BuildSizedBox(),
          BuildText(
            notification.description ?? '',
            color: AppColors.darkViolet,
          ),
        ],
      ),
    );
  }
}
