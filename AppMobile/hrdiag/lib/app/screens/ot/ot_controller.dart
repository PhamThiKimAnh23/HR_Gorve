import 'package:hr_diag/app/base/DropDownItem.dart';
import 'package:hr_diag/app/base_controller.dart';
import 'package:hr_diag/app/core/Shared.dart';
import 'package:hr_diag/app/core/Utility.dart';
import 'package:hr_diag/app/routers/app_routes.dart';
import 'package:get/get.dart';

import '../../base/LoginInfo.dart';
import '../../base/MasterInfo.dart';
import '../../core/HttpUtils.dart';
import '../../core/Urls.dart';
import '../../model/ot_model.dart';

class OTController extends BaseController {
  RxList<OTModel> lstDataOT = RxList.empty(growable: true);
  RxList<OTModel> lstDataOTFilter = RxList.empty(growable: true);
  Rx<DropDownItem> yearValue = (DropDownItem(0, '', 0)).obs;
  Rx<DropDownItem> monthValue = (DropDownItem(0, '', 0)).obs;
  RxList<DropDownItem> employees = RxList.empty(growable: true);
  RxList<DropDownItem> statusData = RxList.empty(growable: true);
  Rx<DropDownItem> employeeValue = DropDownItem(-1, 'Tất cả nhân viên', -1).obs;
  Rx<DropDownItem> statusValue = DropDownItem(-1, 'Tất cả trạng thái', -1).obs;
  RxList<MasterInfo> temp = RxList.empty(growable: true);
  Rx<LoginInfo> user = LoginInfo().obs;
  RxList<DropDownItem> dataYear = new RxList.empty(growable: true);
  RxList<DropDownItem> dataMonth = new RxList.empty(growable: true);

  @override
  Future<void> onInit() async {
    super.onInit();
    init();
  }

  void init() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      try {
        if (!await Utility.isInternetConnected()) {
          errorInterner();
        }
        showEasyLoading();
        user.value = (await Shared.getUser())!;
        for (int i = 1; i <= 12; i++) {
          DropDownItem month = new DropDownItem(i, 'Tháng ' + i.toString(), i);
          dataMonth.add(month);
        }
        dataYear.add(new DropDownItem(2023, 'Năm 2023', 2023));
        dataYear.add(new DropDownItem(2024, 'Năm 2024', 2024));
        dataYear.add(new DropDownItem(2025, 'Năm 2025', 2025));
        employeeType = Get.arguments;
        yearValue.value =
            dataYear.where((e) => e.value == DateTime.now().year).single;
        monthValue.value =
            dataMonth.where((e) => e.value == DateTime.now().month).single;
        dataYear.refresh();
        dataMonth.refresh();
        Future.wait([
          downloadDataOT(
              monthSelect: monthValue.value.value.toString(),
              yearSelect: yearValue.value.value.toString()),
          getMasterList(),
          downloadDataEmployee(),
        ]).then((value) {
          hideEasyLoading();
        }).onError((error, stackTrace) {
          hideEasyLoading();
        });
      } catch (ex) {
        hideEasyLoading();
        alert(content: ex.toString());
        return;
      }
    });
  }

  Future<void> reload() async {
    if (!await Utility.isInternetConnected()) {
      errorInterner();
    }
    try {
      showEasyLoading();
      await downloadDataOT(
          monthSelect: monthValue.value.value.toString(),
          yearSelect: yearValue.value.value.toString());
      hideEasyLoading();
    } catch (ex) {
      hideEasyLoading();
      alert(content: ex.toString());
    }
  }

  Future<void> onAddOTTap() async {
    Get.toNamed(Routes.ADDOT)!.then((value) async {
      reload();
    });
  }

  void onViewOTTap(OTModel info) {
    Get.toNamed(Routes.DETAILOT, arguments: [info, employeeType])!
        .then((value) async {
      reload();
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onChangeDate() {}

  void onChangeYear() {}

  bool onBack() {
    Get.back();
    return false;
  }

  Future<void> getMasterList() async {
    statusData.clear();
    statusData.add(DropDownItem(-1, 'Tất cả trạng thái', -1));
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
            statusData.add(DropDownItem(item.id, item.Name_viVN, item.id));
          }
          statusValue.value = statusData[0];
        }
        statusData.refresh();
      } else {
        alert(content: value.content.toString());
      }
    });
  }

  Future<void> downloadDataEmployee() async {
    List<LoginInfo> temp = List.empty(growable: true);
    employees.clear();
    employees.add(DropDownItem(-1, 'Tất cả nhân viên', -1));
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
          employeeValue.value = employees[0];
        }
        employees.refresh();
      } else {
        alert(content: value.content.toString());
      }
    });
  }

  Future<void> downloadDataOT({String? monthSelect, String? yearSelect}) async {
    lstDataOT.clear();
    Map<String, dynamic> param = new Map();
    param["FUNCTION"] = 'GETLISTOT';
    param['Month'] = monthSelect;
    param['Year'] = yearSelect;
    if (user.value.typeid == 2) {
      if (employeeValue.value.key != -1) {
        param['EmployeeId'] = employeeValue.value.value.toString();
      }
      if (statusValue.value.key != -1) {
        param['Status'] = statusValue.value.value.toString();
      }
    }
    await HttpUtils.post(url: Urls.OT, body: param).then((value) {
      if (value.statusCode == 200) {
        lstDataOT.addAll(
            (value.content as List).map((e) => OTModel.fromJson(e)).toList());
        lstDataOT.refresh();
      } else {
        alert(content: value.content.toString());
      }
    });
  }
}
