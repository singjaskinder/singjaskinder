import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_feedback_controller.dart';

class MyFeedback extends StatelessWidget {
  const MyFeedback({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyFeedbackController());
    return Container();
  }
}
