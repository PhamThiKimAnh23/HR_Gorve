import 'package:hr_diag/app/components/base_app_bar.dart';
import 'package:hr_diag/app/core/AppStyle.dart';
import 'package:hr_diag/app/core/Utility.dart';
import 'package:hr_diag/app/extensions/ExsString.dart';
// import 'package:hr_diag/app/screens/leave/leaveComponents/Separator.dart';
import 'package:hr_diag/app/screens/ot/detail_ot_controller.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailOTView extends GetView<DetailOTController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: BaseAppBar(
            title: Text('Thông tin OT'),
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
                            'Tăng ca ngày: ' + controller.info!.oTDate.toString(),
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
                                'Ngày đăng ký',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(controller.info!.createdTime.toString()),
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
                                'Ngày xác nhận',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(!ExString(controller.info!.confirmTime.toString())
                                      .isNullOrWhiteSpace()
                                  ? controller.info!.confirmTime.toString()
                                  : ''),
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
                                'Trạng thái',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                controller.info!.statusName.toString(),
                                style: TextStyle(
                                    color: controller.info!.status == 0
                                        ? Colors.red.shade700
                                        : controller.info!.status == 2
                                            ? Colors.yellow.shade700
                                            : Colors.green.shade700),
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
                                'Thời gian OT',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(controller.info!.oTValue.toString()),
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
                                'Loại OT',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(controller.info!.oTTargetName.toString()),
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
                                'Nhân viên ghi chú',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                  !ExString(controller.info!.employeeComment.toString())
                                          .isNullOrWhiteSpace()
                                      ? controller.info!.employeeComment.toString()
                                      : ''),
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
                                'Quản lý ghi chú',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                  !ExString(controller.info!.userConfirmComment.toString())
                                          .isNullOrWhiteSpace()
                                      ? controller.info!.userConfirmComment.toString()
                                      : ''),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                          visible: controller.employeeType == 'sup' &&
                              controller.info!.status == 2,
                          child: TextField(
                            controller: controller.editComment,
                            decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.teal)),
                                hintText: 'Ghi chú...',
                                helperText:
                                    'Vui lòng nhập lý do không đồng ý...',
                                labelText: 'Ghi chú',
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.green,
                                ),
                                prefixText: ' ',
                                suffixText: '',
                                suffixStyle:
                                    const TextStyle(color: Colors.green)),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                          visible: controller.employeeType == 'sup' &&
                              controller.info!.status == 2,
                          child: Row(
                            children: [
                              ElevatedButton(
                                child: Text('Đồng ý'),
                                onPressed: () async {
                                  await controller.confirmOT(
                                      controller.info!, 1);
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                child: Text('Không đồng ý'),
                                onPressed: () async {
                                  await controller.confirmOT(
                                      controller.info!, 0);
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ))
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
