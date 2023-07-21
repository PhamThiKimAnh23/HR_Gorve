//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:hr_diag/app/components/base_app_bar.dart';
import 'package:hr_diag/app/screens/salary/salary_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalaryView extends GetView<SalaryController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return controller.obx((state) => WillPopScope(
        child: Scaffold(
          appBar: BaseAppBar(
            title: Text('Salary'),
            rightIsNotify: false,
            height: 50,
            isShowBackGround: false,
            leftIcon: Icons.arrow_back_ios,
            leftClick: () {
              controller.onBack();
            },
          ),
          body: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
              width: size.width,
              height: size.height,
              child: Image.asset(
                'assets/icons/icon_detail_salary.png',
                fit: BoxFit.fill,
                //width: 200,
                //height: 150,
              )), // PDFViewer(document: controller.e_contact)),
        ),
        onWillPop: () async {
          return controller.onBack();
        }));
  }
}
