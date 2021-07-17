import 'dart:ui';

import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/functions/preferences.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

String getImage(String imageName) => 'assets/images/$imageName';

String setDate() => DateTime.now().toIso8601String();

int setTimeStamp() => DateTime.now().millisecondsSinceEpoch;

Color hexToColor(String color) =>
    Color(int.parse(color.replaceAll('#', '0xFF')));

String makePrice(dynamic amount) => '\$ ' + amount.toStringAsFixed(2);

String makeDate(String date) {
  if (date != null) {
    final format = DateFormat('dd MMM, on EEEE ');
    final parsedDate = DateTime.parse(date);
    return format.format(parsedDate);
  } else
    return '';
}

String makeDateTime(String date) {
  if (date != null) {
    final format = DateFormat('dd MMM, E hh:mm a');
    final parsedDate = DateTime.parse(date);
    return format.format(parsedDate);
  } else
    return '';
}

String withCurrency(dynamic amount) => '\$ ' + amount.toString();

String makeImageLink(String link) => ApiHandler.imageBaseUrl + link;

void checkProfileDetails() {
  final name = Preferences.saver.getString('name') ?? '';
  final image = Preferences.saver.getString('image') ?? '';
  final address = Preferences.saver.getString('address') ?? '';
  if (name.isEmpty || image.isEmpty || address.isEmpty) {
    Get.snackbar('Oops', 'You need complete your profile before adding a job',
        backgroundColor: AppColors.white, snackPosition: SnackPosition.BOTTOM);
    Future.delayed(Duration(milliseconds: 1800), () {
      Get.toNamed(Routes.myProfile);
    });
    return;
  }
}
