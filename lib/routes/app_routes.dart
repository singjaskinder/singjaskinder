import 'package:dlivrDriver/views/auth/change_password/change_password.dart';
import 'package:dlivrDriver/views/auth/email_reset_password/email_reset_password.dart';
import 'package:dlivrDriver/views/auth/input_pin/input_pin.dart';
import 'package:dlivrDriver/views/auth/mobile_number/mobile_number.dart';
import 'package:dlivrDriver/views/auth/otp_code/otp_code.dart';
import 'package:dlivrDriver/views/auth/reset_otp_code/reset_otp_code.dart';
import 'package:dlivrDriver/views/build_navigation/build_navigation.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/completed_jobs/completed_jobs.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/help/help.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/home/home.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/inprogress_jobs/inprogress_job_details/inprogress_job_details.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/inprogress_jobs/inprogress_jobs.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/inprogress_jobs/navigate_map/navigate_map.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_biddings/bidded_job_details/bidded_job_details.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_biddings/my_biddings.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_documents/my_documents.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_feedback/my_feedback.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_jobs/add_rating/add_rating.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_jobs/driver_chat/driver_chat.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_jobs/job_details/bid_price/bid_price.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_jobs/job_details/job_details.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_jobs/my_jobs.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_jobs/tracking_details/tracking_details.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_profile/add_address/add_address.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_profile/my_profile.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_profile/profile_details/profile_details.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_profile/set_pin/set_pin.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_profile/update_password/update_password.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_ratings/my_ratings.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_vehicles/au_vehicle/au_vehicle.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/my_vehicles/select_vehicles/my_vehicles.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/notifications/notifications.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/privacy_policy/privacy_policy.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/terms_conditions/terms_conditions.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/view_image/view_image.dart';
import 'package:dlivrDriver/views/congratulation/congratulation.dart';
import 'package:get/get.dart';
import '../views/auth/login/login.dart';
import '../views/auth/register/register.dart';
import '../views/landing/landing.dart';

class Routes {
  static const landing = '/landing';
  static const login = '/login';
  static const inputPin = '/inputPin';
  static const register = '/register';
  static const mobileNumber = '/mobileNumber';
  static const otpCode = '/otpCode';
  static const emailresetPassword = '/resetPassword';
  static const resetOtpCode = '/resetOtpCode';
  static const changePassword = '/changePassword';
  static const congratulation = '/congratulation';
  static const navigator = '/navigator';
  static const home = '/home';
  static const bidPrice = '/bidPrice';
  static const myProfile = '/profile';
  static const profileDetails = '/profileDetails';
  static const setPin = '/setPin';
  static const updatePassword = '/updatePassword';
  static const myRatings = '/ratings';
  static const myJobs = '/jobs';
  static const myDocuments = '/myDocuments';
  static const myBiddings = '/myBiddings';
  static const inprogressJobs = '/inprogressJobs';
  static const completedJobs = '/completedJobs';
  static const myVehicles = '/myVehicles';
  static const selectVehicle = '/selectVehicle';
  static const auVehicle = '/auVehicle';

  static const notifications = '/notifications';
  static const help = '/  help';
  static const privacyPolicy = '/privacyPolicy';
  static const termsConditions = '/termsConditions';
  static const myFeedback = '/myfeedback';
  static const addAddress = '/addAddress';
  static const jobAddedDetails = '/jobAddedDetails';
  static const jobDetails = '/jobDetails';
  static const biddedJobDetails = '/biddedJobDetails';
  static const inprogressJobDetails = '/inProgressJobDetails';
  static const navigateMap = '/navigateMap';

  static const driverChat = '/driverChat';
  static const trackingDetails = '/trackingDetails';
  static const addRating = '/addRating';
  static const viewImage = '/viewImage';

  static void back() => Get.back();

  static final List<GetPage> pages = [
    GetPage(name: landing, page: () => Landing()),
    GetPage(name: login, page: () => Login()),
    GetPage(name: inputPin, page: () => InputPin()),
    GetPage(name: mobileNumber, page: () => MobileNumber()),
    GetPage(name: otpCode, page: () => OtpCode()),
    GetPage(name: emailresetPassword, page: () => EmailResetPassword()),
    GetPage(name: resetOtpCode, page: () => ResetOtpCode()),
    GetPage(name: changePassword, page: () => ChangePassword()),
    GetPage(name: register, page: () => Register()),
    GetPage(name: congratulation, page: () => Congratulation()),
    GetPage(name: navigator, page: () => BuildNavigation()),
    GetPage(name: home, page: () => Home()),
    GetPage(name: bidPrice, page: () => BidPrice()),
    GetPage(name: myProfile, page: () => MyProfile()),
    GetPage(name: profileDetails, page: () => ProfileDetails()),
    GetPage(name: setPin, page: () => SetPin()),
    GetPage(name: updatePassword, page: () => UpdatePassword()),
    GetPage(name: myRatings, page: () => MyRatings()),
    GetPage(name: myJobs, page: () => MyJobs()),
    GetPage(name: myDocuments, page: () => MyDocuments()),
    GetPage(name: myBiddings, page: () => MyBiddings()),
    GetPage(name: inprogressJobs, page: () => InprogressJobs()),
    GetPage(name: completedJobs, page: () => CompletedJobs()),
    GetPage(name: myVehicles, page: () => MyVehicles()),
    GetPage(name: auVehicle, page: () => AUVehicle()),
    GetPage(name: notifications, page: () => ViewNotifications()),
    GetPage(name: help, page: () => Help()),
    GetPage(name: privacyPolicy, page: () => PrivacyPolicy()),
    GetPage(name: termsConditions, page: () => TermsConditions()),
    GetPage(name: myFeedback, page: () => MyFeedback()),
    GetPage(name: addAddress, page: () => AddAddress()),
    GetPage(name: jobDetails, page: () => JobDetails()),
    GetPage(name: biddedJobDetails, page: () => BiddedJobDetails()),
    GetPage(name: inprogressJobDetails, page: () => InprogressJobDetails()),
    GetPage(name: navigateMap, page: () => NavigateMap()),
    GetPage(name: trackingDetails, page: () => TrackingDetails()),
    GetPage(name: driverChat, page: () => DriverChat()),
    GetPage(name: addRating, page: () => AddRating()),
    GetPage(name: viewImage, page: () => ViewImage()),
  ];
}
