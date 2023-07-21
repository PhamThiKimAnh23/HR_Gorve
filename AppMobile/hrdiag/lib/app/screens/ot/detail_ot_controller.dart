import 'package:flutter/material.dart';
import 'package:hr_diag/app/base_controller.dart';
import 'package:get/get.dart';
import 'package:hr_diag/app/core/Utility.dart';
import 'package:intl/intl.dart';

// import '../../base/MasterInfo.dart';
import '../../core/HttpUtils.dart';
import '../../core/Urls.dart';
import '../../model/ot_model.dart';

class DetailOTController extends BaseController {
  OTModel? info;
  TextEditingController editComment = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    info = Get.arguments[0];
    employeeType = Get.arguments[1];
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool onBack() {
    Get.back();
    return false;
  }

  Future<void> confirmOT(OTModel info, int status) async {
    if (!await Utility.isInternetConnected()) {
      errorInterner();
    }
    showEasyLoading();
    Map<String, String> param = new Map();
    param["FUNCTION"] = 'CONFRIMOT';
    param['Id'] = info.id.toString();
    param['Status'] = status.toString();
    param['Comment'] = editComment.text;
    param['ConfirmDate'] =
        DateFormat('dd-MM-yyyy hh:MM:sss').format(DateTime.now()).toString();
    await HttpUtils.post(url: Urls.OT, body: param).then((value) {
      hideEasyLoading();
      if (value.statusCode == 200) {
        confirm1(
            content: value.content.toString(),
            onConfirm: () {
              Get.back();
              Get.back();
            });
      } else {
        alert(content: value.content.toString());
      }
    });
  }
}
