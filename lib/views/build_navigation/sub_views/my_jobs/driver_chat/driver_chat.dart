import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dlivrDriver/common/build_circular_loading.dart';
import 'package:dlivrDriver/common/retry.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/text_field.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/models/api_response/chat_m.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'driver_chat_controller.dart';

class DriverChat extends StatelessWidget {
  const DriverChat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverChatController());
    return BuildViewWithBackground(
      resizeToAvoidBottomInset: true,
      hasBackButton: true,
      haveSafeArea: false,
      positionedImage: Positioned(
        bottom: 0,
        top: 300,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: 0.0,
            child: Image.asset(
              getImage('bg_main0.png'),
            ),
          ),
        ),
      ),
      gradient: AppStyles.darkGradient,
      child: Column(
        children: [
          BuildSizedBox(),
          Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.image.isEmpty
                      ? CircleAvatar(
                          radius: SizeConfig.imageSizeMultiplier * 8,
                          backgroundColor: AppColors.lightViolet,
                          child: Icon(
                            Feather.user,
                            size: SizeConfig.imageSizeMultiplier * 5.5,
                          ),
                        )
                      : CircleAvatar(
                          radius: SizeConfig.imageSizeMultiplier * 8,
                          backgroundColor: AppColors.lightViolet,
                          backgroundImage: NetworkImage(controller.image)),
                  BuildSizedBox(
                    width: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: BuildText(
                      controller.job.userId.name,
                      size: 3.5,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
          BuildSizedBox(),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: controller.watchChats(),
                  builder: (_, snap) {
                    if (snap.hasData) {
                      if (snap.data.docs.isEmpty) {
                        return Center(
                            child: BuildText(
                          'Be nice here',
                          color: AppColors.white,
                        ));
                      }
                      return ListView.builder(
                          controller: controller.scrollController,
                          padding: EdgeInsets.zero,
                          itemCount: snap.data.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (_, i) {
                            final chat =
                                ChatM.fromJson(snap.data.docs[i].data());
                            return ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: 300, minWidth: 10),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: !chat.isUser
                                        ? AppColors.lightViolet
                                        : AppColors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [AppStyles.tileShadow]),
                                child: Column(
                                  crossAxisAlignment: !chat.isUser
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    BuildText(
                                      chat.message,
                                      size: 2.4,
                                    ),
                                    BuildText(
                                      makeDateTime(chat.date),
                                      size: 1.4,
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    } else if (snap.hasError) {
                      print(snap);
                      return BuildRetry(onRetry: () {});
                    } else {
                      return BuildCircularLoading();
                    }
                  })),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: BuildCustomTextField(
                  controller: controller.messageCtrl,
                  hint: 'Type a message....',
                )),
                BuildSizedBox(
                  width: 1.5,
                ),
                Obx(
                  () => InkWell(
                    onTap: () => controller.textEmpty.value
                        ? null
                        : controller.sendMessage(),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: controller.textEmpty.value
                              ? AppColors.darkGrey.withOpacity(0.5)
                              : AppColors.medViolet,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Icon(
                        Feather.send,
                        color: AppColors.white,
                        size: SizeConfig.imageSizeMultiplier * 6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
