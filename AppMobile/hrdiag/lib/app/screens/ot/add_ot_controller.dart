import 'package:flutter/cupertino.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:hr_diag/app/base/DropDownItem.dart';
import 'package:hr_diag/app/base/MasterInfo.dart';
import 'package:hr_diag/app/base_controller.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:hr_diag/app/core/Utility.dart';
import 'package:hr_diag/app/extensions/ExsDate.dart';
import 'package:intl/intl.dart';

import '../../core/HttpUtils.dart';
import '../../core/Urls.dart';

class AddOTController extends BaseController {
  RxString dateString = 'Chọn ngày'.obs;
  int dateInt = 0;
  TextEditingController editOTValue = TextEditingController();
  TextEditingController editComment = TextEditingController();
  RxList<DropDownItem> lstReason = RxList.empty(growable: true);
  Rx<DropDownItem> reasonSelect = DropDownItem(-1, 'Chọn', -1).obs;
  String createTime =
      DateFormat('dd-MM-yyyy hh:MM:sss').format(DateTime.now()).toString();

  @override
  void onInit() {
    getMasterList();
    super.onInit();
  }

  void onChangeDate() {
    DatePicker.showDatePicker(Get.context!, showTitleActions: true,
        onConfirm: (date) {
      dateString.value = date.nowFormat(format: 'dd-MM-yyyy');
      dateInt = Utility.dateTimeToInt(date);
    }, currentTime: DateTime.now(), locale: LocaleType.vi);
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool onBack() {
    Get.back();
    return false;
  }

  Future<void> requestOT() async {
    if (!Utility.isNullOrWhiteSpace(editOTValue.text)) {
      double? otValue = double.tryParse(editOTValue.text);
      if (otValue == null) {
        alert(
            content:
                'Số giờ OT đang nhập không hợp lệ vui lòng kiểm tra lại !');
        return;
      }
    }
    if (!await Utility.isInternetConnected()) {
      errorInterner();
    }
    showEasyLoading();
    Map<String, dynamic> param = new Map();
    param["FUNCTION"] = 'REGISOT';
    param['OTDate'] = dateInt.toString();
    param['OTValue'] = editOTValue.text;
    param['OTTarget'] = reasonSelect.value.value.toString();
    param['EmployeeComment'] = editComment.text;
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

  Future<void> getMasterList() async {
    if (!await Utility.isInternetConnected()) {
      errorInterner();
    }
    showEasyLoading();
    lstReason.clear();
    List<MasterInfo> temp = List.empty(growable: true);
    Map<String, String> param = new Map();
    param["FUNCTION"] = 'MASTERDATA';
    param['ListCode'] = 'OTTYPE';
    await HttpUtils.post(url: Urls.DOWNLOAD, body: param).then((value) {
      hideEasyLoading();
      if (value.statusCode == 200) {
        temp.addAll((value.content as List)
            .map((e) => MasterInfo.fromJson(e))
            .toList());
        if (temp.isNotEmpty) {
          for (MasterInfo item in temp) {
            if (item.listCode == 'OTTYPE') {
              lstReason.add(DropDownItem(item.id, item.name, item.id));
            }
          }
          reasonSelect.value = lstReason[0];
        }
      } else {
        alert(content: value.content.toString());
      }
    });
  }
}
