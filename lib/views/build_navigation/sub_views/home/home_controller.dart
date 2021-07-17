import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart' as Dio;
import 'package:dlivrDriver/common/bottom_sheet_image.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/models/api_response/coupon_m.dart';
import 'package:dlivrDriver/models/api_response/vehicle_m.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  final pageController = PageController();
  Completer<GoogleMapController> mapController = Completer();
  final polylines = Set<Polyline>().obs;
  CameraPosition initialPos;
  final vehicles = <Vehicles>[].obs;
  final vehicleLoading = true.obs;
  final currentPage = 1.obs;
  final sourceAddress = 'Pickup'.obs;
  final destinationAddress = 'Destination'.obs;
  LatLng sourceLocation;
  LatLng destinationLocation;
  Map<String, dynamic> jobDetails;
  final prevVehicleIndex = (-1).obs;
  final currentVehicleIndex = 0.obs;
  final nextVehicleIndex = 1.obs;
  final currentDistance = (1.0).obs;

  final jobtypes = <JobType>[
    JobType(
        image: '1.png', title: 'One item only', description: 'One item only'),
    JobType(
        image: '2.png', title: 'Two item only', description: 'Two item only'),
    JobType(
        image: '3.png',
        title: 'Office furniture removal',
        description: 'To remove whole office furniture'),
    JobType(
        image: '4.png',
        title: 'House removal',
        description: 'Complete house furniture reomoval'),
  ];
  final extraHelps = [
    'No, I can manage',
    'Yes 1 person would be okay',
    'I need 2 people'
  ];
  final selectedExtraHelp = ''.obs;
  final jobTypeSelected = 0.obs;
  final formKey3 = GlobalKey<FormState>();
  final descriptionCtrl = TextEditingController();
  final noofItemCtrl = TextEditingController();
  final packageSizeCtrl = TextEditingController();
  final packageWeightCtrl = TextEditingController();
  final selectedImage = ''.obs;

  final selectedDeliveryDate = 'Select your delivery date'.obs;
  final selectedBiddingDate = 'Select end date for bidding'.obs;
  final isAsap = false.obs;
  final sendNotification = false.obs;

  final formKey5 = GlobalKey<FormState>();
  final amountCtrl = TextEditingController();
  final selectedCoupon = Coupon().obs;
  final estimatedBudget = (0.0).obs;
  double actualBudget = 0.0;
  final finalBudget = (0.0).obs;

  @override
  void onInit() {
    super.onInit();
    selectedExtraHelp.value = null;
    getVehicles();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changePage(int pageNo) {
    pageController.animateToPage(pageNo - 1,
        duration: Duration(milliseconds: 800), curve: Curves.ease);
  }

  Future<List<Vehicles>> getVehicles() async {
    vehicleLoading.value = true;
    try {
      final res = await ApiHandler.getHttp(EndPoints.getVehicleCategory);
      vehicles.value = VehicleM.fromJson(res.data).vehicles;
      vehicleLoading.value = false;
      print('done');
    } catch (e) {
      print(e);
    }
    return vehicles;
  }

  void selectedAddress(bool isSource) async {
    Navigator.push(
      Get.context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: 'AIzaSyAXUZJV__NaYwjpvaMjAfZgZ4AqfaG5gww',
          onPlacePicked: (PickResult result) {
            final latitude = result.geometry.location.lat;
            final longitude = result.geometry.location.lng;
            if (isSource) {
              sourceAddress.value = result.formattedAddress;
              sourceLocation = LatLng(latitude, longitude);
            } else {
              destinationAddress.value = result.formattedAddress;
              destinationLocation = LatLng(latitude, longitude);
            }
            if (sourceLocation != null && destinationLocation != null) {
              getPlotDetails();
            }
            Navigator.of(context).pop();
          },
          initialPosition: (isSource ? sourceLocation : destinationLocation) ??
              initialPos.target,
          useCurrentLocation: false,
        ),
      ),
    );
  }

  Future<void> getPlotDetails() async {
    currentDistance.value = calculateDistance(
        sourceLocation.latitude,
        sourceLocation.longitude,
        destinationLocation.latitude,
        destinationLocation.longitude);
    if (currentDistance.value < 1) {
      currentDistance.value = 1;
    }
    estimatedBudget.value =
        vehicles[currentVehicleIndex.value].baseValue * currentDistance.value;
    print(currentDistance.value);
    PolylinePoints polylinePoints = PolylinePoints();
    isLoading(true);
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyAXUZJV__NaYwjpvaMjAfZgZ4AqfaG5gww',
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );
    List<LatLng> polylineCoordinates = [];
    result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
    Map<PolylineId, Polyline> polyLines = {};
    final id = PolylineId('poly');
    Polyline polyline = Polyline(
        polylineId: id,
        color: AppColors.medViolet,
        width: 5,
        points: polylineCoordinates);
    polyLines[id] = polyline;
    polylines.clear();
    isLoading(false);
    this.polylines.addAll(polyLines.values);
    LatLng tempLocation;
    if (destinationLocation.latitude > sourceLocation.latitude) {
      tempLocation = sourceLocation;
      sourceLocation = destinationLocation;
      destinationLocation = tempLocation;
    }

    final GoogleMapController mapController1 = await mapController.future;
    mapController1.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: destinationLocation,
          northeast: sourceLocation,
        ),
        12.0,
      ),
    );
  }

  String getPrice(double amount) {
    return makePrice((amount * currentDistance.value));
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Vehicles getPrev() {
    if (prevVehicleIndex.value <= -1) {
      return vehicles[0];
    }
    return vehicles[prevVehicleIndex.value];
  }

  Vehicles getCurrent() {
    return vehicles[currentVehicleIndex.value];
  }

  Vehicles getNext() {
    if (nextVehicleIndex.value > vehicles.length) {
      return vehicles[0];
    }
    return vehicles[nextVehicleIndex.value];
  }

  void changeVehicle(bool isNext) {
    if (isNext) {
      if (currentVehicleIndex.value < vehicles.length - 1) {
        prevVehicleIndex.value++;
        currentVehicleIndex.value++;
        nextVehicleIndex.value++;
      }
    } else {
      if (currentVehicleIndex.value != 0) {
        prevVehicleIndex.value--;
        currentVehicleIndex.value--;
        nextVehicleIndex.value--;
      }
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
    selectedImage.value = imageFile.path;
  }

  void selectDate(bool isDelivery) async {
    DateTime selectedDate;
    final DateTime picked = await showDatePicker(
      context: Get.context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime(2025, 1, 1),
      builder: (_, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.deepPurple,
            ),
            timePickerTheme: TimePickerTheme.of(Get.context).copyWith(),
          ),
          child: child,
        );
      },
    );
    if (picked != null) {
      selectedDate = picked;
      if (isDelivery) {
        selectedDeliveryDate.value = selectedDate.toIso8601String();
      } else {
        selectedBiddingDate.value = selectedDate.toIso8601String();
      }
    }
  }

  int getExtraPeople() {
    if (selectedExtraHelp.contains('no'))
      return 0;
    else if (selectedExtraHelp.contains('1'))
      return 1;
    else if (selectedExtraHelp.contains('2'))
      return 2;
    else
      return 0;
  }

  void pageDecide() async {
    switch (currentPage.value) {
      case 1:
        checkProfileDetails();
        if (sourceAddress.value.isNotEmpty &&
            sourceAddress.value != 'Pickup' &&
            destinationAddress.value.isNotEmpty &&
            destinationAddress.value != 'Destination') {
          changePage(2);
        } else {
          showSnack('Please select pickup and Destination location');
        }
        break;
      case 2:
        changePage(3);
        break;
      case 3:
        if (formKey3.currentState.validate() &&
            selectedExtraHelp.value != null &&
            selectedImage.value.isNotEmpty) {
          formKey3.currentState.save();
          changePage(4);
        } else {
          showSnack(null);
        }
        break;
      case 4:
        if (!selectedDeliveryDate.value.contains('Select') &&
            !selectedBiddingDate.value.contains('Select')) {
          changePage(5);
        } else {
          showSnack(null);
        }
        break;
      case 5:
        if (formKey5.currentState.validate()) {
          formKey5.currentState.save();
          actualBudget = double.parse(amountCtrl.text);
          final priceDifference = estimatedBudget.value - actualBudget;
          if (selectedCoupon.value?.offValue == null) {
            if (priceDifference > 100) {
              BuildRetryBottomSheet(Get.context, Routes.back,
                  text: 'Enter budget is too low, please enter higher amount',
                  errored: true,
                  cancellable: false);
              return;
            }
          }
          if (finalBudget.value == 0.0) {
            if (selectedCoupon.value?.offValue == null) {
              finalBudget.value = actualBudget;
              return;
            } else {
              final discount = selectedCoupon.value.offValue;
              finalBudget.value =
                  actualBudget - (actualBudget * discount / 100);
              return;
            }
          }
          final data = Dio.FormData.fromMap({
            'pick_latitude': sourceLocation.latitude,
            'pick_longitude': sourceLocation.longitude,
            'pick_address': sourceAddress,
            'drop_latitude': destinationLocation.latitude,
            'drop_longitude': destinationLocation.longitude,
            'drop_address': destinationAddress,
            'job_type': jobtypes[jobTypeSelected.value].title,
            'package_title': jobtypes[jobTypeSelected.value].description,
            'package_description': descriptionCtrl.text,
            'no_of_item': int.parse(noofItemCtrl.text),
            'package_size': int.parse(packageSizeCtrl.text),
            'package_weight': int.parse(packageWeightCtrl.text),
            // TODO: change extra help value from index
            'extra_help': getExtraPeople(),
            'delivered_date': selectedDeliveryDate.value,
            'bidding_end_date': selectedBiddingDate.value,
            'fast_delivery': isAsap.value,
            'send_noitification': sendNotification.value,
            'estimated_budget': estimatedBudget.value,
            'actual_budget': actualBudget,
            'final_budget': finalBudget.value,
            'tracking_link': 'updating',
            'status': 'bidding',
            'delievered': false,
            'job_images': await Dio.MultipartFile.fromFile(selectedImage.value,
                contentType: MediaType('image', 'jpeg'))
          });
          try {
            isLoading(true);
         
            isLoading(false);
            Get.toNamed(Routes.jobAddedDetails);
          } on Dio.DioError catch (e) {
            print(e);
            isLoading(false);
            BuildRetryBottomSheet(Get.context, pageDecide,
                errored: true, cancellable: false);
          }
        } else {
          showSnack(null);
        }
        break;
    }
  }

  void showSnack(String text) {
    Get.snackbar('Oops', text ?? 'Please fill all the details',
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.zero,
        borderRadius: 0,
        backgroundColor: AppColors.white,
        colorText: AppColors.medViolet);
  }

  void tocoupons() async {
    finalBudget.value = 0.0;
  }

  void clearData() {
    sourceLocation = null;
    destinationLocation = null;
    sourceAddress.value = 'Pickup';
    destinationAddress.value = 'Destination';
    polylines.clear();
    jobTypeSelected.value = 0;
    descriptionCtrl.clear();
    packageSizeCtrl.clear();
    packageWeightCtrl.clear();
    selectedExtraHelp.value = null;
    selectedDeliveryDate.value = 'Select your delivery date';
    selectedBiddingDate.value = 'Select end date for bidding';
    isAsap.value = false;
    sendNotification.value = false;
    prevVehicleIndex.value = (-1);
    currentVehicleIndex.value = 0;
    nextVehicleIndex.value = 1;
    currentDistance.value = (1.0);
    selectedCoupon.value = null;
    estimatedBudget.value = (0.0);
    actualBudget = 0.0;
    finalBudget.value = (0.0);
    selectedImage.value = '';
    amountCtrl.clear();
  }
}

class JobType {
  String image;
  String title;
  String description;
  JobType({this.image, this.title, this.description});
}
