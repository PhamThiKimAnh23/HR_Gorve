import 'package:hr_diag/app/base/DropDownItem.dart';
import 'package:hr_diag/app/components/base_app_bar.dart';
import 'package:hr_diag/app/components/base_gradient_button.dart';
import 'package:hr_diag/app/core/Utility.dart';
import 'package:hr_diag/app/screens/leave/add_leave_controller.dart';
// import 'package:hr_diag/app/screens/leave/leave_controller.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../components/base_date_picker.dart';
import '../../components/base_textfield.dart';
import '../../core/DecimalTextInputFormatter.dart';
import 'leaveComponents/Separator.dart';
// import 'leaveComponents/chooseDateTime.dart';

class AddLeave extends GetView<AddLeaveController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: controller.onBack,
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: BaseAppBar(
                title: Text('Đăng ký nghỉ phép'),
                rightIsNotify: false,
                height: 50,
                isShowBackGround: false,
                leftIcon: Icons.arrow_back_ios,
                leftClick: () {
                  controller.onBack();
                },
              ),
              body: body(context),
            )));
  }

  Widget body(BuildContext context) {
    return Obx(() => Container(
      height: Utility.getHeightScreen(context),
      width: Utility.getWidthScreen(context),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5E5),
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                VerticalDivider(
                  thickness: 5,
                  color: const Color(0xFF40A9FF),
                ),
                Text(
                  'Thông tin',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Color(0xFFFFFFFF),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Ngày đăng ký'),
                      ),
                      Expanded(
                        flex: 1,
                        child: BaseDatePicker(
                          date: controller.dateString.value,
                          width: Utility.getWidthScreen(context),
                          height: 40,
                          onTap: () {
                            controller.onChangeDate();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Số ngày nghỉ'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: BaseTextField(
                            inputFormatter: [
                              DecimalTextInputFormatter(decimalRange: 1),
                              FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                            ],
                            textInputType:
                            TextInputType.numberWithOptions(decimal: true, signed: true),
                            placeHolder: '',
                            controller: controller.editLeaveValue,
                            borderColor: Colors.grey,
                            radius: 10,
                            height: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Lý do'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 100,
                          height: 40,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: DropdownButton<DropDownItem>(
                                    underline: SizedBox(),
                                    isExpanded: true,
                                    onChanged: (DropDownItem? item) {
                                      controller.leaveReason.value = item!;
                                    },
                                    value: controller.leaveReason.value,
                                    items: controller.lstLeaveReason
                                        .map((DropDownItem value) {
                                      return DropdownMenuItem<DropDownItem>(
                                        value: value,
                                        child: Container(
                                          child: Text(
                                            value.lable,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  )),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Color(0xFFD9D9D9),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextFormField(
                      controller: controller.editComment,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Separator(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 40,
                  //       child: Icon(
                  //         Icons.select_all,
                  //         color: Color(0xFF40A9FF),
                  //       ),
                  //     ),
                  //     LimitedBox(
                  //       maxWidth: 150,
                  //       child: Text(
                  //         'Tên chủ CH',
                  //         style: TextStyle(fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //     Container(
                  //       padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                  //       constraints:
                  //           BoxConstraints(maxWidth: 200, minHeight: 30),
                  //       margin: EdgeInsets.only(
                  //           left: 40, top: 10, bottom: 10, right: 10),
                  //       decoration: BoxDecoration(
                  //         border: Border.all(color: Color(0xFFC6C6C6)),
                  //         color: Color(0xFFE6F7FF),
                  //       ),
                  //       child: Text("Nguyễn Văn A",style: TextStyle(color: Color(0xFF40A9FF),fontSize: 16),),
                  //     )
                  //   ],
                  // ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 60, 10, 0),
                      child: BaseGradientButton(
                        onPressed: () {controller.requestLeave();},
                        text: 'Gửi yêu cầu đến cấp quản lý',
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
