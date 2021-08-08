import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/common/bottom_sheet_image.dart';
import 'package:dlivrDriver/common/document_tile.dart';
import 'package:dlivrDriver/models/api_response/my_vehicle_m.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_vehicles/select_vehicles/my_vehicles.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_vehicles/select_vehicles/my_vehicles_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:dio/dio.dart' as Dio;

class AUVehicleController extends GetxController {
  final isUpdate = false.obs;
  final image = ''.obs;
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final colorCtrl = TextEditingController();
  final noCtrl = TextEditingController();
  final capacityCtrl = TextEditingController();
  String type;
  MyVehiclesM myVehicle;
  final docs = [
    DocumentM(label: 'Registration Certificate', imageData: ''),
    DocumentM(label: 'Insurance Certificate', imageData: ''),
    DocumentM(label: 'Inspection Certificate', imageData: ''),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    final res = Get.arguments;
    if (res['new']) {
      type = res['value'];
    } else {
      isUpdate.value = true;
      myVehicle = res['value'];
      image.value = makeImageLink(myVehicle.vehicleImage);
      type = myVehicle.type;
      nameCtrl.text = myVehicle.name;
      colorCtrl.text = myVehicle.color;
      noCtrl.text = myVehicle.number;
      capacityCtrl.text = myVehicle.loadCapacity.toString();
      docs[0].imageData = makeImageLink(myVehicle.registrationCertificate);
      docs[1].imageData = makeImageLink(myVehicle.insuranceCertificate);
      docs[2].imageData = makeImageLink(myVehicle.inspectionCertificate);
    }
  }

  void imageControl() {
    if (image.value.isEmpty) {
      showImageBottomSheet();
    } else {
      if (image.value.contains('http')) {}
      image.value = '';
    }
  }

  void showImageBottomSheet() {
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
            getImage(false);
          },
          onCameraTap: () {
            Get.back();
            getImage(true);
          },
        );
      },
    );
  }

  Future<void> getImage(bool fromCamera) async {
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
    image.value = imageFile.path;
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

  void removeVehicle() async {
    try {
      isLoading(true);
      await ApiHandler.deleteHttp(EndPoints.deleteUpdateVehicle, null,
          params: myVehicle.sId);
      isLoading(false);
      Get.back();
      MyVehiclesController myVehiclesController = Get.find();
      myVehiclesController.update();
    } on Dio.DioError catch (e) {
      print(e);
      isLoading(false);
      BuildRetryBottomSheet(Get.context, removeVehicle,
          autoClose: true, errored: true, cancellable: false);
    }
  }

  Future<void> auVehicle() async {
    if (image.isEmpty) {
      Get.snackbar('Oops', 'You need to add vehicle image',
          backgroundColor: AppColors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    for (DocumentM doc in docs) {
      if (doc.imageData.isEmpty) {
        Get.snackbar('Oops', 'You need to add all the documents',
            backgroundColor: AppColors.white,
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
    }
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        final data = Dio.FormData.fromMap({
          'name': nameCtrl.text,
          'color': colorCtrl.text,
          'number': noCtrl.text,
          'load_capacity': int.parse(capacityCtrl.text),
          'type': type,
          'vehicle_image': isNetWorkImage(image.value)
              ? image.value
              : await Dio.MultipartFile.fromFile(image.value,
                  contentType: MediaType('image', 'jpeg')),
          'registration_certificate': isNetWorkImage(docs[0].imageData)
              ? docs[0].imageData
              : await Dio.MultipartFile.fromFile(docs[0].imageData,
                  contentType: MediaType('image', 'jpeg')),
          'insurance_certificate': isNetWorkImage(docs[0].imageData)
              ? docs[0].imageData
              : await Dio.MultipartFile.fromFile(docs[0].imageData,
                  contentType: MediaType('image', 'jpeg')),
          'inspection_certificate': isNetWorkImage(docs[2].imageData)
              ? docs[2].imageData
              : await Dio.MultipartFile.fromFile(docs[2].imageData,
                  contentType: MediaType('image', 'jpeg'))
        });
        isLoading(true);
        if (isUpdate.value) {
          await ApiHandler.putHttp(EndPoints.putUpdateVehicle, data,
              params: myVehicle.sId);
        } else {
          await ApiHandler.postHttp(EndPoints.postAddVehicle, data,
              isDefault: true);
          clearData();
        }
        MyVehiclesController myVehiclesController = Get.find();
        myVehiclesController.update();
        isLoading(false);
        BuildRetryBottomSheet(Get.context, Get.back,
            text: 'Vehicle ' + (isUpdate.value ? 'updated' : 'added'),
            label: 'OK',
            done: true,
            errored: true,
            cancellable: false);
      } on Dio.DioError catch (e) {
        print(e.message);
        print('ssssssssssssss');
        isLoading(false);
        BuildRetryBottomSheet(Get.context, () {
          Get.back();
          auVehicle();
        }, errored: true, cancellable: false);
      }
    }
  }

  void clearData() {
    image.value = '';
    for (DocumentM doc in docs) {
      doc.imageData = '';
    }
    nameCtrl.clear();
    colorCtrl.clear();
    noCtrl.clear();
    capacityCtrl.clear();
  }

  void decide(bool process, DocumentM document) {}
}
