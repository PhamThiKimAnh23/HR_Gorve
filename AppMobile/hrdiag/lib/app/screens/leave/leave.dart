// ignore_for_file: invalid_use_of_protected_member

import 'package:hr_diag/app/components/base_app_bar.dart';
import 'package:hr_diag/app/components/base_dropdown.dart';
import 'package:hr_diag/app/components/base_gradient_button.dart';
import 'package:hr_diag/app/components/base_time_dropdown.dart';
import 'package:hr_diag/app/core/Utility.dart';
import 'package:hr_diag/app/screens/leave/leaveComponents/chooseDateTime.dart';
import 'package:hr_diag/app/screens/leave/leaveComponents/countContainer.dart';
import 'package:hr_diag/app/screens/leave/leave_controller.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'leaveComponents/leave_list.dart';

class Leave extends GetView<LeaveController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: controller.onBack,
        child: Scaffold(
          appBar: BaseAppBar(
            title: Text('Nghỉ phép'),
            rightIsNotify: false,
            height: 50,
            isShowBackGround: false,
            leftIcon: Icons.arrow_back_ios,
            leftClick: () {
              controller.onBack();
            },
          ),
          body: body(context),
        ));
  }

  Widget body(BuildContext context) {
    return Obx(() => Container(
        height: Utility.getHeightScreen(context),
        width: Utility.getWidthScreen(context),
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Visibility(
                                visible: false,
                                child: Expanded(
                                  child: ChooseDateTime(
                                    height: 50,
                                    hint: "Year",
                                  ),
                                  flex: 1,
                                )),
                            Expanded(
                              flex: 1,
                              child: BaseTimeDropDown(
                                value: controller.yearValue.value,
                                data: controller.years,
                                height: 40,
                                function: (value) {
                                  controller.yearValue.value = value;
                                  controller.downloadDataLeave(
                                      monthSelect: controller
                                          .monthValue.value.value
                                          .toString(),
                                      yearSelect: controller
                                          .yearValue.value.value
                                          .toString());
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Visibility(
                                visible: false,
                                child: Expanded(
                                  child: ChooseDateTime(
                                    height: 50,
                                    hint: "Month",
                                  ),
                                  flex: 1,
                                )),
                            Expanded(
                              flex: 1,
                              child: BaseTimeDropDown(
                                value: controller.monthValue.value,
                                data: controller.months,
                                height: 40,
                                function: (value) {
                                  controller.monthValue.value = value;
                                  controller.downloadDataLeave(
                                      monthSelect: controller
                                          .monthValue.value.value
                                          .toString(),
                                      yearSelect: controller
                                          .yearValue.value.value
                                          .toString());
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Visibility(
                          visible: controller.employeeType == 'sup',
                          child: Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                      flex: 1,
                                      child: BaseDropDown(
                                        value: controller.employeeValue.value,
                                        data: controller.employees.value,
                                        height: 40,
                                        function: (value) {
                                          controller.employeeValue.value =
                                              value;
                                          controller.downloadDataLeave(
                                              monthSelect: controller
                                                  .monthValue.value.value
                                                  .toString(),
                                              yearSelect: controller
                                                  .yearValue.value.value
                                                  .toString());
                                        },
                                      ),
                                    ),
                                SizedBox(
                                  width: 10,
                                ),
                                 Expanded(
                                      flex: 1,
                                      child: BaseDropDown(
                                        value: controller.statusValue.value,
                                        data: controller.statusData,
                                        height: 40,
                                        function: (value) {
                                          controller.statusValue.value = value;
                                          controller.downloadDataLeave(
                                              monthSelect: controller
                                                  .monthValue.value.value
                                                  .toString(),
                                              yearSelect: controller
                                                  .yearValue.value.value
                                                  .toString());
                                        },
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.all(5),
                  color: const Color(0xFFFFFFFF),
                  child: Column(
                    children: [
                      Visibility(
                          visible: controller.employeeType != 'sup',
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CountContainer(
                                  colorIconTitle: const Color(0xFFFF4D4F),
                                  colorBackgroundIcon: const Color(0xFFFDEEEA),
                                  title1: controller.totalDayOffUsed.value,
                                  title2: "Ngày phép đã dùng",
                                  icon: Icons.confirmation_num_outlined,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 1,
                                child: CountContainer(
                                  colorIconTitle: const Color(0xFF40A9FF),
                                  colorBackgroundIcon: const Color(0xFFE4F3F4),
                                  title1: controller.totalStockDayOff.value,
                                  title2: "Ngày phép còn lại",
                                  icon: Icons.format_list_numbered,
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        decoration: BoxDecoration(
                            color: const Color(0xFF1E9FF2).withOpacity(0.1),
                            border: Border.all(color: const Color(0xFFEBEBEB)),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Visibility(
                                    visible: controller.employeeType == 'sup',
                                    child: Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            "Nhân viên",
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ))),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        "Ngày off",
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        "Lý do",
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        "Số ngày",
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        "Trạng thái",
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                       Expanded(child: RefreshIndicator(child:LeaveList(),onRefresh: ()=> controller.search(),)),
                       Visibility(visible: controller.employeeType != 'sup', child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: BaseGradientButton(
                              onPressed: () {
                                controller.toAdd();
                              },
                              text: 'Đăng ký nghỉ phép',
                            ),
                          ),
                        ))
                    ],
                  ),
                ))
          ],
        )));
  }
}
