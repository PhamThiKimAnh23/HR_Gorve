// ignore_for_file: unnecessary_null_comparison

import 'package:hr_diag/app/components/base_app_bar.dart';
import 'package:hr_diag/app/components/base_dropdown.dart';
import 'package:hr_diag/app/components/base_gradient_button.dart';
import 'package:hr_diag/app/components/base_time_dropdown.dart';
import 'package:hr_diag/app/screens/ot/component/list_ot_item.dart';
import 'package:hr_diag/app/screens/ot/ot_controller.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'component/list_ot.dart';

class ManagerOTView extends GetView<OTController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        child: Scaffold(
            appBar: BaseAppBar(
              title: Text('Đăng ký OT'),
              rightIsNotify: false,
              height: 50,
              isShowBackGround: false,
              leftIcon: Icons.arrow_back_ios,
              leftClick: () {
                controller.onBack();
              },
            ),
            body: Container(
              width: size.width,
              height: size.height,
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                              child: Obx(() => BaseTimeDropDown(
                                    value: controller.yearValue.value,
                                    data: controller.dataYear,
                                    height: 40,
                                    function: (value) {
                                      controller.yearValue.value = value;
                                      controller.reload();
                                    },
                                  ))),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Obx(() => BaseTimeDropDown(
                                    value: controller.monthValue.value,
                                    data: controller.dataMonth,
                                    height: 40,
                                    function: (value) {
                                      controller.monthValue.value = value;
                                      controller.reload();
                                    },
                                  )))
                        ],
                      )),
                    ],
                  ),
                ),
                Obx(() => Visibility(
                    visible: controller.user.value.typeid == 2,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: (controller.employees != null &&
                                    controller.employees.length >= 2)
                                ? BaseDropDown(
                                    value: controller.employeeValue.value,
                                    data: controller.employees,
                                    height: 40,
                                    function: (value) {
                                      controller.employeeValue.value = value;
                                      controller.reload();
                                    },
                                  )
                                : SizedBox(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: (controller.statusData != null &&
                                    controller.statusData.length >= 2)
                                ? BaseDropDown(
                                    value: controller.statusValue.value,
                                    data: controller.statusData,
                                    height: 40,
                                    function: (value) {
                                      controller.statusValue.value = value;
                                      controller.reload();
                                    },
                                  )
                                : SizedBox(),
                          ),
                        ],
                      ),
                    ))),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Obx(
                      () => getTitleByPosition(controller.user.value.typeid)),
                ),
                Expanded(
                    child: Obx(() => ListView.builder(
                          shrinkWrap: false,
                          itemCount: controller.lstDataOT.length,
                          itemBuilder: (buildContext, index) {
                            return ItemOT(controller.lstDataOT[index]);
                          },
                        ))),
                Obx(() => Visibility(
                    visible: controller.user.value.typeid == 3,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: BaseGradientButton(
                          onPressed: () {
                            controller.onAddOTTap();
                          },
                          text: 'Đăng ký',
                        ),
                      ),
                    )))
              ]),
            )),
        onWillPop: () async {
          return controller.onBack();
        });
  }

  Widget getTitleByPosition(int type) {
    return Row(
      children: [
        textTitle(type == 3 ? 'Ngày OT' : 'NViên'),
        textTitle(type == 3 ? 'Loại OT' : 'Ngày OT'),
        textTitle(type == 3 ? 'Số giờ OT' : 'Loại OT'),
        textTitle(type == 3 ? 'Trạng thái' : 'Số giờ OT'),
        Visibility(
          visible: type == 2,
          child: textTitle(type == 3 ? 'Trạng thái' : 'Trạng thái'),
        )
      ],
    );
  }

  Widget textTitle(String title) {
    return Expanded(
        child: Container(
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
      ),
    ));
  }
}
