// ignore_for_file: deprecated_member_use

import 'dart:async';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:hr_diag/app/base/ShopInfo.dart';
// import 'package:hr_diag/app/core/NotifcationService.dart';
// import 'package:hr_diag/app/routers/app_routes.dart';
//import 'package:progress_dialog/progress_dialog.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import 'base/DropDownItem.dart';
import 'base/WorkResultInfo.dart';

abstract class BaseController extends FullLifeCycleController
    with StateMixin, SingleGetTickerProviderMixin {
  ProgressDialog? progess;
  Rx<WorkResultInfo>? work;
  List<DropDownItem>? years = new List.empty(growable: true);
  List<DropDownItem>? months = new List.empty(growable: true);
  String? employeeType;

  @override
  void onInit() {
    for (int i = 1; i <= 12; i++) {
      // ignore: unused_local_variable
      DropDownItem employee =
          new DropDownItem(i, 'Employee ' + i.toString(), i);
      DropDownItem month = new DropDownItem(i, 'Tháng ' + i.toString(), i);
      months!.add(month);
    }
    years!.add(new DropDownItem(2023, 'Năm 2023', 2023));
    years!.add(new DropDownItem(2024, 'Năm 2024', 2024));
    years!.add(new DropDownItem(2025, 'Năm 2025', 2025));

    // EasyLoading.addStatusCallback((status) {
    //   if (state == EasyLoadingStatus.show) {
    //     Timer(const Duration(seconds: 5), () {
    //       EasyLoading.dismiss();
    //     });
    //   }
    // });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void alert({String title = 'Thông báo', @required String? content}) {
    Get.defaultDialog(
        title: title,
        titleStyle: TextStyle(color: Colors.black, fontSize: 18),
        middleText: content!,
        middleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        radius: 10,
        barrierDismissible: false,
        buttonColor: Colors.white,
        textConfirm: 'Đóng',
        onConfirm: () {
          Get.back();
        },
        confirmTextColor: Colors.blue[500]);
  }

  void errorInterner() {
    alert(
        title: "Thông báo Internet",
        content: "Kết nối của bạn không ổn định, vui lòng kiểm tra lại");
    return;
  }

  Future<void> isEnableGPS() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    // ignore: unnecessary_null_comparison
    if (isLocationServiceEnabled == null || !isLocationServiceEnabled) {
      alert(
          title: "GPS Notifications",
          content: "Please enable GPS before taking pictures.");
      return;
    }
  }

  void confirm(
      {String title = 'Thông báo',
      @required String? content,
      VoidCallback? onConfirm,
      VoidCallback? onCancel}) {
    Get.defaultDialog(
        title: title,
        titleStyle: TextStyle(color: Colors.black, fontSize: 18),
        middleText: content!,
        middleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        radius: 10,
        barrierDismissible: false,
        buttonColor: Colors.white,
        textConfirm: 'Đồng ý',
        textCancel: 'Không',
        cancelTextColor: Colors.red[500],
        confirmTextColor: Colors.blue[500],
        onConfirm: onConfirm != null
            ? onConfirm
            : () {
                Get.back();
              },
        onCancel: onCancel);
  }

  confirmOK({String? content, VoidCallback? functionOk}) async {
    Get.defaultDialog(
      barrierDismissible: false,
      title: "Thông báo",
      titlePadding: EdgeInsets.only(top: 20),
      content: Padding(padding: EdgeInsets.all(10), child: Text(content!)),
      textConfirm: "Ok",
      onConfirm: functionOk,
    );
  }

  void confirm1({
    String? content,
    Function()? onConfirm,
  }) {
    showGeneralDialog(
        barrierDismissible: false,
        context: Get.context!,
        pageBuilder: (ctx, a1, a2) {
          return Container();
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                .animate(anim1),
            child: WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                titlePadding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                contentPadding: const EdgeInsets.only(top: 10.0),
                title: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: Color(0xFF2196F3)),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'Thông báo',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                content: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    content!,
                    style: const TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: onConfirm,
                      child: Text('Ok',
                          style: const TextStyle(
                              color: Colors.blue, fontSize: 17))),
                ],
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        useRootNavigator: false);
  }

  configLoading() async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  Future<void> showEasyLoading() async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    EasyLoading.show(dismissOnTap: false);
  }

  Future<void> hideEasyLoading() async {
    EasyLoading.dismiss();
  }

  Future<bool> backPressed() async {
    Get.back(result: "result");
    return false;
  }
}
