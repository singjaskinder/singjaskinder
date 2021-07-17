import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/notification_m.dart';
import 'package:dlivrDriver/views/build_navigation/sub_views/notifications/notifications.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  Future<List<Notifications>> getNotifications() async {
    // final res = await ApiHandler.getHttp(EndPoints.getNotifications);
    // return  NotificationM.fromJson(res.data).notifications;
    return [];
  }
}
