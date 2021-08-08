import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:dlivrDriver/models/api_response/user_m.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences saver;
  static Future<void> init() async {
    saver = await SharedPreferences.getInstance();
  }

  static void saveUserDetails(UserM userM) {
    final userData = userM.userData[0];
    if (userData.token != null) {
      saver.setString('auth_token', userData.token);
    }
    print(userData.toJson());
    saver.setString('id', userData.id ?? '');
    saver.setString('id', userData.sId ?? '');
    saver.setString('email', userData.email ?? '');
    saver.setString('name', userData.name ?? '');
    saver.setString('phone', userData.phone ?? '');
    saver.setString('stripe_id', userData.stripeCustomerId ?? '');
    saver.setString(
        'image',
        userData.profileImage == null
            ? ''
            : makeImageLink(userData.profileImage));
    saver.setString('ratings', userData.totalRating?.toString() ?? '');
  }

  static Future<void> getDeviceInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    saver.setString('fcm_token', fcmToken);
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      saver.setString('build', packageInfo.version);
      saver.setString('device_id', androidInfo.androidId);
      saver.setString('model', androidInfo.model);
      saver.setString('device', 'android');
    } else {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      saver.setString('build', packageInfo.version);
      saver.setString('device_id', iosDeviceInfo.identifierForVendor);
      saver.setString('model', iosDeviceInfo.model);
      saver.setString('device', 'ios');
    }
  }

  static String getId() => saver.getString('id');
  static String getToken() => saver.getString('auth_token');
  static String getFcmToken() => saver.getString('fcm_token');
  static String getBuild() => saver.getString('build');
  static String getDeviceId() => saver.getString('device_id');
  static String getDevice() => saver.getString('device');
  static String getModel() => saver.getString('model');
  static String getName() => saver.getString('name');
  static String getPhone() => saver.getString('phone');
  static String getImage() => saver.getString('image');
  static String getRatings() => saver.getString('ratings');
}
