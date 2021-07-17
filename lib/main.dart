import 'package:dlivrDriver/utils/functions/preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'res/app_colors.dart';
import 'routes/app_routes.dart';
import 'utils/size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Preferences.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Future.delayed(const Duration(seconds: 2), () async {
    await FirebaseMessaging.instance.subscribeToTopic('driver');
  });
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(Pramukh());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

class Pramukh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return OrientationBuilder(
        builder: (_, orientation) {
          SizeConfig().init(constraints, orientation);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorScheme: const ColorScheme.dark().copyWith(
                  primary: AppColors.medViolet,
                  brightness: Brightness.light,
                ),
                scaffoldBackgroundColor: AppColors.white,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                primaryColor: AppColors.violet,
                accentColor: AppColors.violet,
                primaryColorLight: AppColors.violet,
                primaryColorDark: AppColors.violet,
                indicatorColor: AppColors.violet,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: AppColors.transparent)),
            initialRoute: Routes.landing,
            getPages: Routes.pages,
          );
        },
      );
    });
  }
}
