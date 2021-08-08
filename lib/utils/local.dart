import 'dart:ui';

import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/common/document_tile.dart';
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

bool isNetWorkImage(String image) {
  return image.contains('http');
}

final docs = [
  DocumentM(label: 'driving_license', imageData: ''),
  DocumentM(label: 'passport', imageData: ''),
  DocumentM(label: 'australian_citizenship', imageData: ''),
  DocumentM(label: 'australian_visa', imageData: ''),
  DocumentM(label: 'residence_proof', imageData: ''),
  DocumentM(label: 'bank_card', imageData: ''),
  DocumentM(label: 'medicare', imageData: ''),
  DocumentM(label: 'federal_police_check', imageData: ''),
  DocumentM(label: 'driving_history', imageData: ''),
];

bool checkProfileDetails() {
  final name = Preferences.saver.getString('name') ?? '';
  final image = Preferences.saver.getString('image') ?? '';
  final address = Preferences.saver.getString('address') ?? '';
  if (name.isEmpty || image.isEmpty) {
    Get.snackbar(
        'Oops', 'You need complete your profile before applying to a job',
        backgroundColor: AppColors.white, snackPosition: SnackPosition.BOTTOM);
    Future.delayed(Duration(milliseconds: 1800), () {
      Get.toNamed(Routes.profileDetails);
    });
    return false;
  } else if (address.isEmpty) {
    Get.snackbar('Oops', 'You need to address before applying to a job',
        backgroundColor: AppColors.white, snackPosition: SnackPosition.BOTTOM);
    Future.delayed(Duration(milliseconds: 1800), () {
      Get.toNamed(Routes.profileDetails);
    });
    return false;
  }
  return true;
}

bool checkDocuments() {
  final drivingLicense = Preferences.saver.getString('driving_license');
  final passport = Preferences.saver.getString('passport');
  final australianCitizenship =
      Preferences.saver.getString('australian_citizenship');
  final australianVisa = Preferences.saver.getString('australian_visa');
  final residenceProof = Preferences.saver.getString('residence_proof');
  final bankCard = Preferences.saver.getString('bank_card');
  final medicare = Preferences.saver.getString('medicare');
  final federalPoliceCheck =
      Preferences.saver.getString('federal_police_check');
  final drivingHistory = Preferences.saver.getString('driving_history');
  if (drivingLicense.isEmpty ||
      passport.isEmpty ||
      australianCitizenship.isEmpty ||
      residenceProof.isEmpty ||
      australianVisa.isEmpty ||
      bankCard.isEmpty ||
      medicare.isEmpty ||
      federalPoliceCheck.isEmpty ||
      drivingHistory.isEmpty) {
    Get.snackbar('Oops', 'You add all the documents before applying to a job',
        backgroundColor: AppColors.white, snackPosition: SnackPosition.BOTTOM);
    Future.delayed(Duration(milliseconds: 1800), () {
      Get.toNamed(Routes.profileDetails);
    });
    return false;
  }
  return true;
}
