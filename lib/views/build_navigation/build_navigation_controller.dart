import 'package:dio/dio.dart';
import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/models/api_response/driver_m.dart';
import 'package:dlivrDriver/models/api_response/user_m.dart';
import 'package:dlivrDriver/models/nav_menu.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/functions/preferences.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class BuildNavigationController extends GetxController {
  final imageUrl = ''.obs;
  final userName = ''.obs;
  final ratings = ''.obs;
  final sideNavMenus = <NavMenuM>[
    NavMenuM(
      iconData: Feather.user,
      label: 'My Profile',
      route: Routes.myProfile,
    ),
    NavMenuM(
      iconData: Feather.file,
      label: 'My Documents',
      route: Routes.myDocuments,
    ),
    NavMenuM(
      iconData: Feather.briefcase,
      label: 'My Bidding',
      route: Routes.myBiddings,
    ),
    NavMenuM(
      iconData: Feather.loader,
      label: 'Inprogress Jobs',
      route: Routes.inprogressJobs,
    ),
    NavMenuM(
      iconData: Feather.check_square,
      label: 'Completed Jobs',
      route: Routes.completedJobs,
    ),
    NavMenuM(
      iconData: Feather.truck,
      label: 'My Vehicles',
      route: Routes.myVehicles,
    ),
    NavMenuM(
      iconData: Feather.bell,
      label: 'Notifications',
      route: Routes.notifications,
    ),

    NavMenuM(
      iconData: Feather.help_circle,
      label: 'Help',
      route: Routes.help,
    ),
    NavMenuM(
      iconData: Feather.list,
      label: 'Privacy Policy',
      route: Routes.privacyPolicy,
    ),
    NavMenuM(
      iconData: Feather.align_justify,
      label: 'Terms & Conditions',
      route: Routes.termsConditions,
    ),
    // NavMenuM(
    //   iconData: Feather.message_square,
    //   label: 'Feedback',
    //   route: Routes.myFeedback,
    // ),
    NavMenuM(
      iconData: Feather.log_out,
      label: 'Log out',
      route: Routes.home,
    ),
  ];

  @override
  void onReady() {
    super.onReady();
    getUserDetails();
  }

  void selectMenu(int i) {
    Get.back();
    if (i == sideNavMenus.length - 1) {
      BuildBottomSheet(
        Get.context,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              getImage('info.png'),
              width: SizeConfig.imageSizeMultiplier * 30,
            ),
            BuildSizedBox(),
            BuildText('You Sure want to logout?',
                size: 2.5,
                color: AppColors.violet,
                fontWeight: FontWeight.w400),
            BuildSizedBox(),
            BuildPrimaryButton(
              onTap: () => logout(),
              label: 'Logout',
            ),
            BuildSizedBox(height: 1.6),
            BuildPrimaryButton(
              isOutLined: true,
              onTap: () => Routes.back(),
              label: 'Cancel',
            ),
          ],
        ),
      );
    } else {
      Get.toNamed(sideNavMenus[i].route);
    }
  }

  void toRatings() => Get.toNamed(Routes.myRatings);

  void getUserDetails() async {
    try {
      isLoading(true);
      final res = await ApiHandler.getHttp(EndPoints.getDriverDetails);
      final userM = UserM.fromJson(res.data);
      Preferences.saveUserDetails(userM);
      userName.value = Preferences.getName();
      imageUrl.value = Preferences.getImage() ?? '';
      String rating = Preferences.getRatings();
      final details = DriverM.fromJson(res.data).details;
      final primaryDoc = details[0].primaryDocument;
      final secondaryDoc = details[0].secondaryDocument;
      final additionalDoc = details[0].additionalDocument;
      if (primaryDoc.isNotEmpty) {
        Preferences.saver.setString(
            'driving_license', makeImageLink(primaryDoc[0].drivingLicense));
        Preferences.saver
            .setString('passport', makeImageLink(primaryDoc[0].passport));
        Preferences.saver.setString('australian_citizenship',
            makeImageLink(secondaryDoc[0].australianCitizenship));
        Preferences.saver.setString(
            'australian_visa', makeImageLink(secondaryDoc[0].australianVisa));
        Preferences.saver.setString(
            'residence_proof', makeImageLink(secondaryDoc[0].residenceProof));
        Preferences.saver
            .setString('bank_card', makeImageLink(secondaryDoc[0].bankCard));
        Preferences.saver
            .setString('medicare', makeImageLink(secondaryDoc[0].medicare));
        Preferences.saver.setString('federal_police_check',
            makeImageLink(secondaryDoc[0].federalPoliceCheck));
        Preferences.saver.setString(
            'driving_history', makeImageLink(additionalDoc[0].drivingHistory));
      }
      if (rating.isEmpty) {
      } else {
        final ratingContent = rating.split('.')[0];
        if (ratingContent == '0') {
          ratings.value = '';
        } else {
          ratings.value = ratingContent;
        }
      }
      isLoading(false);
    } on DioError catch (e) {
      print(e.response);
      print(e.response.statusCode);
      isLoading(false);
      BuildRetryBottomSheet(Get.context, getUserDetails,
          label: 'OK', errored: true, cancellable: false);
    }
  }

  void logout() {
    Preferences.saver.clear();
    Get.offAllNamed(Routes.login);
  }
}
