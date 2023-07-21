import 'package:hr_diag/app/core/Utility.dart';
import 'package:hr_diag/app/extensions/ExsString.dart';
import 'package:hr_diag/app/screens/welcome/welcome_controller.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeView extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: Container(
            alignment: Alignment.center,
            width: Utility.getWidthScreen(context),
            height: Utility.getHeightScreen(context),
            child: Obx(() => Center(child: Text('Welcome '+(ExString(controller.employeeName.value).isNullOrWhiteSpace() ? '' : controller.employeeName.value),style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),)),
          ),
        );
  }
}
