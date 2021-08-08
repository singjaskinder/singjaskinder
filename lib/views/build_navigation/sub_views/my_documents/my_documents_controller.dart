import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/common/bottom_sheet_image.dart';
import 'package:dlivrDriver/common/document_tile.dart';
import 'package:dlivrDriver/models/api_response/driver_m.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/functions/preferences.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:dio/dio.dart' as Dio;

class MyDocumentsController extends GetxController {
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

  @override
  void onReady() {
    super.onReady();
    getUserDocs();
  }

  void docControl(int i, bool remove) {
    if (remove) {
      if (docs[i].imageData.contains('http')) {}
      docs[i].imageData = '';
      update();
    } else {
      if (docs[i].imageData.isEmpty) {
        showDocBottomSheet(i);
      } else {
        Get.toNamed(Routes.viewImage, arguments: docs[i].imageData);
      }
    }
  }

  void showDocBottomSheet(int i) {
    showModalBottomSheet(
      context: Get.context,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      builder: (_) {
        return BuildSelectImageBottomSheet(
          onGalleryTap: () {
            Get.back();
            getDoc(i, false);
          },
          onCameraTap: () {
            Get.back();
            getDoc(i, true);
          },
        );
      },
    );
  }

  Future<void> getDoc(int i, bool fromCamera) async {
    final picker = ImagePicker();
    PickedFile imageFile;
    if (fromCamera) {
      imageFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 40,
      );
    } else {
      imageFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 40,
      );
    }
    if (imageFile == null) {
      return;
    }
    docs[i].imageData = imageFile.path;
    update();
  }

  void updateDocuments() async {
    for (DocumentM doc in docs) {
      if (doc.imageData.isEmpty) {
        Get.snackbar('Oops', 'You need to add all the documents',
            backgroundColor: AppColors.white,
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
    }
    try {
      final data = Dio.FormData.fromMap({
        docs[0].label: isNetWorkImage(docs[0].imageData)
            ? docs[0].imageData
            : await Dio.MultipartFile.fromFile(docs[0].imageData,
                contentType: MediaType('image', 'jpeg')),
        docs[1].label: isNetWorkImage(docs[0].imageData)
            ? docs[0].imageData
            : await Dio.MultipartFile.fromFile(docs[0].imageData,
                contentType: MediaType('image', 'jpeg')),
        docs[2].label: isNetWorkImage(docs[2].imageData)
            ? docs[2].imageData
            : await Dio.MultipartFile.fromFile(docs[2].imageData,
                contentType: MediaType('image', 'jpeg')),
        docs[3].label: isNetWorkImage(docs[3].imageData)
            ? docs[3].imageData
            : await Dio.MultipartFile.fromFile(docs[3].imageData,
                contentType: MediaType('image', 'jpeg')),
        docs[4].label: isNetWorkImage(docs[4].imageData)
            ? docs[4].imageData
            : await Dio.MultipartFile.fromFile(docs[4].imageData,
                contentType: MediaType('image', 'jpeg')),
        docs[5].label: isNetWorkImage(docs[5].imageData)
            ? docs[5].imageData
            : await Dio.MultipartFile.fromFile(docs[5].imageData,
                contentType: MediaType('image', 'jpeg')),
        docs[6].label: isNetWorkImage(docs[6].imageData)
            ? docs[6].imageData
            : await Dio.MultipartFile.fromFile(docs[6].imageData,
                contentType: MediaType('image', 'jpeg')),
        docs[7].label: isNetWorkImage(docs[7].imageData)
            ? docs[7].imageData
            : await Dio.MultipartFile.fromFile(docs[7].imageData,
                contentType: MediaType('image', 'jpeg')),
        docs[8].label: isNetWorkImage(docs[8].imageData)
            ? docs[8].imageData
            : await Dio.MultipartFile.fromFile(docs[8].imageData,
                contentType: MediaType('image', 'jpeg')),
      });
      await ApiHandler.putHttp(
        EndPoints.putAddDocument,
        data,
      );
      // Preferences.saver.setString(, );
      isLoading(false);
      BuildRetryBottomSheet(Get.context, Get.back,
          text: 'Details Updated',
          label: 'OK',
          done: true,
          errored: true,
          cancellable: false);
    } on Dio.DioError catch (e) {
      print(e);
      isLoading(false);
      BuildRetryBottomSheet(Get.context, updateDocuments,
          autoClose: true, errored: true, cancellable: false);
    }
  }

  void getUserDocs() async {
    try {
      isLoading(true);
      final res = await ApiHandler.getHttp(EndPoints.getDriverDetails);
      final details = DriverM.fromJson(res.data).details;
      final primaryDoc = details[0].primaryDocument;
      final secondaryDoc = details[0].secondaryDocument;
      final additionalDoc = details[0].additionalDocument;
      if (primaryDoc.isNotEmpty) {
        Preferences.saver
            .setString('driving_license', primaryDoc[0].drivingLicense);
        Preferences.saver.setString('passport', primaryDoc[0].passport);
        Preferences.saver.setString(
            'australian_citizenship', secondaryDoc[0].australianCitizenship);
        Preferences.saver
            .setString('australian_visa', secondaryDoc[0].australianVisa);
        Preferences.saver
            .setString('residence_proof', secondaryDoc[0].residenceProof);
        Preferences.saver.setString('bank_card', secondaryDoc[0].bankCard);
        Preferences.saver.setString('medicare', secondaryDoc[0].medicare);
        Preferences.saver.setString(
            'federal_police_check', secondaryDoc[0].federalPoliceCheck);
        Preferences.saver
            .setString('driving_history', additionalDoc[0].drivingHistory);
        docs[0].imageData = primaryDoc[0].drivingLicense;
        docs[1].imageData = primaryDoc[0].passport;
        docs[2].imageData = secondaryDoc[0].australianCitizenship;
        docs[3].imageData = secondaryDoc[0].australianVisa;
        docs[4].imageData = secondaryDoc[0].residenceProof;
        docs[5].imageData = secondaryDoc[0].bankCard;
        docs[6].imageData = secondaryDoc[0].medicare;
        docs[7].imageData = secondaryDoc[0].federalPoliceCheck;
        docs[8].imageData = additionalDoc[0].drivingHistory;
      }
      update();
      isLoading(false);
    } on Dio.DioError catch (e) {
      isLoading(false);
      print(e);
    }
  }
}
