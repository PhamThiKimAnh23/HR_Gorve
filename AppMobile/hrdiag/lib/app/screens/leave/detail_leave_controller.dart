import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hr_diag/app/base_controller.dart';
import 'package:hr_diag/app/model/off_model.dart';

import '../../core/HttpUtils.dart';
import '../../core/Urls.dart';

class DetailLeaveController extends BaseController{
  late OffModel info;
  TextEditingController editComment = TextEditingController();

  @override
  onInit(){
    info = Get.arguments[0];
    employeeType = Get.arguments[1];
    editComment.text = info.userConfirmComment!;
    super.onInit();
  }

  Future<bool> onBack() async {
    Get.back();
    return false;
  }

  Future<void> confirmLeave({int? confirm}) async {
    Map<String, dynamic> param = new Map();
    param["FUNCTION"] = 'CONFRIMOFF';
    param["Id"] = info.id.toString();
    param['Status'] = confirm.toString();
    param['Commnet'] = editComment.text;
    await HttpUtils.post(url: Urls.OT, body: param).then((value) {
      if (value.statusCode == 200) {
        confirm1(content: value.content.toString(),onConfirm: (){
          Get.back();
          Get.back();
        });
      } else {
        alert(content: value.content.toString());
      }
    });
  }
}