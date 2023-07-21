import 'package:flutter/services.dart';
import 'package:hr_diag/app/components/base_app_bar.dart';
import 'package:hr_diag/app/components/base_date_picker.dart';
import 'package:hr_diag/app/components/base_gradient_button.dart';
import 'package:hr_diag/app/components/base_textfield.dart';
import 'package:hr_diag/app/core/AppStyle.dart';
import 'package:hr_diag/app/core/DecimalTextInputFormatter.dart';
import 'package:hr_diag/app/core/Utility.dart';
import 'package:hr_diag/app/screens/ot/add_ot_controller.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';

import '../../components/base_dropdown.dart';

class AddOTView extends GetView<AddOTController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
            width: Utility.getWidthScreen(context),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    color: const Color(0xFFE5E5E5),
                    width: Utility.getWidthScreen(context),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            child: VerticalDivider(
                              color: AppStyle.primary,
                              thickness: 5,
                            ),
                          ),
                          Text(
                            'Thông tin',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  width: Utility.getWidthScreen(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Ngày',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Obx(() => Expanded(
                                  flex: 1,
                                  child: BaseDatePicker(
                                    date: controller.dateString.value,
                                    width: Utility.getWidthScreen(context),
                                    height: 40,
                                    onTap: () {
                                      controller.onChangeDate();
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Số giờ OT',
                                style: TextStyle(fontSize: 17),
                              ),
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
                                  controller: controller.editOTValue,
                                  borderColor: Colors.grey,
                                  radius: 10,
                                  height: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Loại tăng ca',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Obx(() => Expanded(
                                  flex: 1,
                                  child: BaseDropDown(
                                    height: 40,
                                    // ignore: invalid_use_of_protected_member
                                    data: controller.lstReason.value,
                                    value: controller.reasonSelect.value,
                                    function: (value) {
                                      controller.reasonSelect.value = value;
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: false,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Ngày đăng ký',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey, width: 1)),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 0, 0, 0),
                                              child: Text(
                                                controller.createTime,
                                              )))),
                                ),
                              ],
                            ),
                          )),
                      Container(
                        height: 100,
                        margin: EdgeInsets.only(top: 10),
                        child: BaseTextField(
                          enabled: true,
                          radius: 5,
                          textInputType: TextInputType.multiline,
                          maxLines: 3,
                          controller: controller.editComment,
                          borderColor: Colors.grey,
                          placeHolder: 'Ghi chú...',
                          onChanged: (content) {},
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                          child: BaseGradientButton(
                            onPressed: () {
                              controller.requestOT();
                            },
                            text: 'Gửi yêu cầu đến cấp quản lý',
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return controller.onBack();
        });
  }
}
