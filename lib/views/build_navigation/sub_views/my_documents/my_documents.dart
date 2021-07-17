import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_documents_controller.dart';
class MyDocuments extends StatelessWidget {
const MyDocuments({Key key}) : super(key: key);

            @override
            Widget build(BuildContext context) {
            final controller = Get.put(MyDocumentsController());
            return Scaffold();
           }
        }