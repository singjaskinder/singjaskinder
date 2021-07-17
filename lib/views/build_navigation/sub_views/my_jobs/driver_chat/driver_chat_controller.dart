import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dlivrDriver/apis/chatting.dart';
import 'package:dlivrDriver/models/api_response/chat_m.dart';
import 'package:dlivrDriver/models/api_response/job_m.dart';
import 'package:dlivrDriver/overlays/bottom_sheet.dart';
import 'package:dlivrDriver/overlays/progress_dialog.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DriverChatController extends GetxController {
  final ChatRepo chatRepo = ChatApis();
  Jobs job;
  String image;
  String driverId;
  double bidAmount;
  bool isCompleted;
  final textEmpty = true.obs;
  final messageCtrl = TextEditingController();
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    final res = Get.arguments;
    job = res['job_details'];
    image = job.driverDetails.image == null
        ? ''
        : makeImageLink(job.driverDetails.image);
    driverId = job.driverDetails.sId;
    isCompleted = job.status == 'completed';
    messageCtrl.addListener(() {
      textEmpty.value = messageCtrl.text.isEmpty;
      print(messageCtrl.text.isEmpty);
    });
  }

  void sendMessage() async {
    try {
      isLoading(true);
      final chat = ChatM(
          message: messageCtrl.text,
          date: setDate(),
          timeStamp: setTimeStamp(),
          isUser: true);
      await chatRepo.sendChat(chat, job.sId);
      messageCtrl.clear();
      isLoading(false);
      scrollBottom();
    } catch (e) {
      print(e);
      isLoading(false);
      BuildRetryBottomSheet(Get.context, () {
        Get.back();
        sendMessage();
      }, errored: true, cancellable: false);
    }
  }

  Stream<QuerySnapshot> watchChats() async* {
    scrollBottom();
    yield* chatRepo.watchChats(job.sId);
  }

  void scrollBottom() {
    Future.delayed(Duration(milliseconds: 500), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 600), curve: Curves.easeOut);
    });
  }
}
