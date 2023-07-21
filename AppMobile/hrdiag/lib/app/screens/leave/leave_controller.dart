// import 'package:get_storage/get_storage.dart';
import 'package:hr_diag/app/base/DropDownItem.dart';
import 'package:hr_diag/app/base_controller.dart';
import 'package:hr_diag/app/model/off_model.dart';
import 'package:hr_diag/app/routers/app_routes.dart';
import 'package:get/get.dart';

import '../../base/LoginInfo.dart';
import '../../base/MasterInfo.dart';
import '../../core/HttpUtils.dart';
import '../../core/Urls.dart';
import '../../core/Utility.dart';

class LeaveController extends BaseController {
  Rx<DateTime>? date;
  RxList<DropDownItem> lstLeaveReason = RxList.empty(growable: true);
  Rx<DropDownItem> leaveReason = DropDownItem(0, 'Paid holidays', 0).obs;
  RxList<DropDownItem> employees = RxList.empty(growable: true);
  RxList<DropDownItem> statusData = RxList.empty(growable: true);
  Rx<DropDownItem> employeeValue = (DropDownItem(-1, 'Chọn', -1)).obs;
  Rx<DropDownItem> statusValue = (DropDownItem(-1, 'Chọn', -1)).obs;
  Rx<DropDownItem> yearValue = (DropDownItem(0, '', 0)).obs;
  Rx<DropDownItem> monthValue = (DropDownItem(0, '', 0)).obs;
  RxList<OffModel> lstDataOff = RxList.empty(growable: true);
  RxString totalDayOffUsed = 'N/A'.obs;
  RxString totalStockDayOff = 'N/A'.obs;

  @override
  void onInit() {
    super.onInit();
    date = DateTime.now().obs;
    employeeType = Get.arguments;
    yearValue.value = years!.where((e) => e.value == DateTime.now().year).single;
    monthValue.value = months!.where((e) => e.value == DateTime.now().month).single;
    search();
  }

  Future<void> search() async {
    employeeValue = (DropDownItem(-1, 'Chọn', -1)).obs;
    statusValue = (DropDownItem(-1, 'Chọn', -1)).obs;
    await getMasterList().whenComplete(() async {
      await downloadDataEmployee().whenComplete(() async {
        await downloadDataLeave(
            monthSelect: monthValue.value.value.toString(),
            yearSelect: yearValue.value.value.toString());
      });
    });
  }

  Future<bool> onBack() async {
    Get.back();
    return false;
  }

  toDetail(OffModel info) {
    Get.toNamed(Routes.DETAILLEAVE,
        preventDuplicates: false,
        arguments: [info, employeeType])!.then((value) => search());
  }

  toAdd() {
    Get.toNamed(Routes.ADDLEAVE, preventDuplicates: false)!
        .then((value) => search());
  }

  Future<void> setDate(DateTime date) async {
    print('confirm $date');
  }

  Future<void> setReason(DropDownItem item) async {
    leaveReason.value = item;
  }

  Future<void> isConnected() async {
    if (!await Utility.isInternetConnected()) {
      alert(content: "Vui lòng bật internet.");
      return;
    }
  }

  Future<void> downloadDataEmployee() async {
    List<LoginInfo> temp = List.empty(growable: true);
    employees.clear();
    Map<String, dynamic> param = new Map();
    param["FUNCTION"] = 'GETEMPLOYEELIST';
    await HttpUtils.post(url: Urls.OT, body: param).then((value) {
      if (value.statusCode == 200) {
        temp.addAll(
            (value.content as List).map((e) => LoginInfo.fromJson(e)).toList());
        if (temp.isNotEmpty) {
          for (LoginInfo item in temp) {
            employees.add(DropDownItem(
                item.employeeId, item.employeeName, item.employeeId));
          }
          employees.insert(0, employeeValue.value);
          employeeValue.value = employees[0];
        }
        employees.refresh();
      } else {
        alert(content: value.content.toString());
      }
    });
  }

  Future<void> getMasterList() async {
    statusData.clear();
    List<MasterInfo> temp = List.empty(growable: true);
    Map<String, String> param = new Map();
    param["FUNCTION"] = 'MASTERDATA';
    param['ListCode'] = 'REQUEST_STATUS';
    await HttpUtils.post(url: Urls.DOWNLOAD, body: param).then((value) {
      if (value.statusCode == 200) {
        temp.addAll((value.content as List)
            .map((e) => MasterInfo.fromJson(e))
            .toList());
        if (temp.isNotEmpty) {
          for (MasterInfo item in temp) {
            statusData.add(DropDownItem(item.id, item.nameVN, item.id));
          }
          statusData.insert(0, statusValue.value);
          statusValue.value = statusData[0];
        }
        statusData.refresh();
      } else {
        alert(content: value.content.toString());
      }
    });
  }

  Future<void> downloadDataLeave(
      {String? monthSelect, String? yearSelect}) async {
    showEasyLoading();
    lstDataOff.clear();
    Map<String, String> param = new Map();
    param["FUNCTION"] = 'GETLISTOFF';
    param['Month'] = monthSelect!;
    param['Year'] = yearSelect!;
    if (employeeType == 'sup') {
      employeeValue.value.value != -1
          ? param['EmployeeId'] = employeeValue.value.value.toString()
          : null;
      statusValue.value.value != -1
          ? param['Status'] = statusValue.value.value.toString()
          : null;
    }
    await HttpUtils.post(url: Urls.OT, body: param).then((value) {
      hideEasyLoading();
      if (value.statusCode == 200) {
        lstDataOff.addAll((value.content as List)
            .map((e) => OffModel.fromJson(e))
            .toList());
        if(lstDataOff.isNotEmpty){
          totalStockDayOff.value = lstDataOff[0].totalStockDayOff.toString();
          totalDayOffUsed.value = lstDataOff[0].totalDayOffUsed.toString();
        }
        lstDataOff.refresh();
      } else {
        alert(content: value.content.toString());
      }
    });
  }
}
