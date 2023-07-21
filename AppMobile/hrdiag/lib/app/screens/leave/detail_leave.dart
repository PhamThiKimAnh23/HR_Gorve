import 'package:hr_diag/app/components/base_app_bar.dart';
// import 'package:hr_diag/app/components/base_gradient_button.dart';
// import 'package:hr_diag/app/core/AppStyle.dart';
import 'package:hr_diag/app/core/Utility.dart';
// import 'package:hr_diag/app/model/off_model.dart';
import 'package:hr_diag/app/screens/leave/detail_leave_controller.dart';
import 'package:hr_diag/app/screens/leave/leaveComponents/Separator.dart';
// import 'package:hr_diag/app/screens/leave/leave_controller.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DetailLeave extends GetView<DetailLeaveController> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: BaseAppBar(
            title: Text('Thông tin nghỉ phép'),
            rightIsNotify: false,
            height: 50,
            isShowBackGround: false,
            leftIcon: Icons.arrow_back_ios,
            leftClick: () {
              controller.onBack();
            },
          ),
          body: body(context),
        ),
        onWillPop: controller.onBack);
  }

  Widget body(BuildContext context) {
    return Container(
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
                        child: Text('Ngày nghỉ phép'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          !Utility.isNullOrWhiteSpace(controller.info.oFFDate.toString()) ? controller.info.oFFDate.toString() : '',
                          textAlign: TextAlign.end,
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
                        child: Text('Số ngày nghỉ phép'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          !Utility.isNullOrWhiteSpace(controller.info.offValue.toString()) ? controller.info.offValue.toString() : '',
                          textAlign: TextAlign.end,
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
                        child: Text(
                          !Utility.isNullOrWhiteSpace(controller.info.oFFTypeName.toString()) ? controller.info.oFFTypeName.toString() : '',
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: Text('Ghí chú'),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        !Utility.isNullOrWhiteSpace(controller.info.employeeComment.toString()) ? controller.info.employeeComment.toString() : '',
                        textAlign: TextAlign.end,
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: Text('Trạng thái'),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        !Utility.isNullOrWhiteSpace(controller.info.statusName.toString()) ? controller.info.statusName.toString() : '',
                        textAlign: TextAlign.end,
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Separator(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (controller.employeeType == 'sup')
                    TextField(
                      controller: controller.editComment,
                      enabled: controller.info.status == 2,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          hintText: 'Quản lý note',
                          labelText: 'Ghi chú',
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.green,
                          ),
                          prefixText: ' ',
                          suffixText: '',
                          suffixStyle: const TextStyle(color: Colors.green)),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                    Visibility(visible: controller.employeeType == 'sup' && controller.info.status == 2, child: Row(
                      children: [
                        ElevatedButton(
                          child: Text('Đồng ý'),
                          onPressed: () {controller.confirmLeave(confirm: 1);},
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              textStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          child: Text('Không đồng ý'),
                          onPressed: () {
                            controller.confirmLeave(confirm: 0);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              textStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ))
                  // SizedBox(height: 20,),
                  // Row(
                  //   children: [
                  //     SizedBox(width: 40,child: Icon(Icons.select_all,color: Color(0xFF40A9FF),),),
                  //     LimitedBox(maxWidth: 150,child: Text('Tên chủ CH',style: TextStyle(fontWeight: FontWeight.bold),),),
                  //     Container(
                  //       padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                  //       constraints:
                  //       BoxConstraints(maxWidth: 200, minHeight: 30),
                  //       margin: EdgeInsets.only(
                  //           left: 40, top: 10, bottom: 10, right: 10),
                  //       decoration: BoxDecoration(
                  //         border: Border.all(color: Color(0xFFC6C6C6)),
                  //         color: Color(0xFFE6F7FF),
                  //       ),
                  //       child: Text("Nguyễn Văn A",style: TextStyle(color: Color(0xFF40A9FF),fontSize: 16),),
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
