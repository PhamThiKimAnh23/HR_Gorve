import 'package:flutter/cupertino.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:hr_diag/app/base_controller.dart';
import 'package:hr_diag/app/core/Utility.dart';
import 'package:hr_diag/app/extensions/ExsDate.dart';
import '../../base/DropDownItem.dart';
import '../../base/MasterInfo.dart';
import '../../core/HttpUtils.dart';
import '../../core/Urls.dart';

class AddLeaveController extends BaseController{
  RxString dateString = 'Chọn ngày'.obs;
  int dateInt = 0;
  TextEditingController editLeaveValue = TextEditingController();
  RxList<DropDownItem> lstLeaveReason = RxList.empty(growable: true);
  Rx<DropDownItem> leaveReason = DropDownItem(0, '', 0).obs;
  RxList<DropDownItem> employees = RxList.empty(growable: true);
  RxList<DropDownItem> statusData = RxList.empty(growable: true);
  Rx<DropDownItem> employeeValue = (DropDownItem(0, '', 0)).obs;
  Rx<DropDownItem> statusValue = (DropDownItem(0, '', 0)).obs;
  TextEditingController editComment = TextEditingController();
  @override
  void onInit(){

    statusData.add(new DropDownItem(1, 'Agree', 1));
    statusData.add(new DropDownItem(2, 'Disagree', 2));
    statusData.add(new DropDownItem(3, 'Wait', 3));
    statusValue.value = statusData[0];
    getMasterList();
    super.onInit();
  }

  Future<bool> onBack() async {
    Get.back();
    return false;
  }

  Future<void> getMasterList() async {
    if(!await Utility.isInternetConnected()){
      alert(content: "Vui lòng bật internet.");
      return;
    }
    showEasyLoading();
    lstLeaveReason.clear();
    List<MasterInfo> temp = List.empty(growable: true);
    Map<String, String> param = new Map();
    param["FUNCTION"] = 'MASTERDATA';
    param['ListCode'] = 'OFF_TYPE';
    await HttpUtils.post(url: Urls.DOWNLOAD,
        body: param).then((value){
      hideEasyLoading();
      if (value.statusCode == 200) {
        temp.addAll((value.content as List).map((e) => MasterInfo.fromJson(e)).toList());
        if(temp.isNotEmpty){
          for(MasterInfo item in temp){
            if(item.listCode == 'OFF_TYPE'){
              lstLeaveReason.add(DropDownItem(item.id, item.name, item.id));
            }
          }
          leaveReason.value = lstLeaveReason[0];
        }
        lstLeaveReason.refresh();
      }else{
        // alert(content: value.content);
        alert(content: value.content.toString());
      }
    });
  }

  void onChangeDate() {
    DatePicker.showDatePicker(Get.context!, showTitleActions: true,
        onConfirm: (date) {
          dateString.value = date.nowFormat(format: 'dd-MM-yyyy');
          dateInt = Utility.dateTimeToInt(date);
        }, currentTime: DateTime.now(), locale: LocaleType.vi);
  }

  Future<void> requestLeave() async {
    showEasyLoading();
    Map<String, dynamic> param = new Map();
    param["FUNCTION"] = 'REGISOFF';
    param['OffDate'] = dateInt.toString();
    param['OffValue'] = editLeaveValue.text;
    param['OffType'] = leaveReason.value.value.toString();
    param['EmployeeComment'] = editComment.text;
    await HttpUtils.post(url: Urls.OT,
        body: param).then((value){
      hideEasyLoading();
      if (value.statusCode == 200) {
        confirm1(content: value.content.toString(),onConfirm:(){
          Get.back();
          Get.back();
        });
      }else{
        alert(content: value.content.toString());
      }
    });
  }

}