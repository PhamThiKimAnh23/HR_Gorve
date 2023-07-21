import 'package:hr_diag/app/base/TabInfo.dart';
import 'package:hr_diag/app/core/DateTimes.dart';
import 'package:hr_diag/app/core/Utility.dart';
import 'package:hr_diag/app/routers/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../base/LoginInfo.dart';
import '../../../base_controller.dart';
import '../../../core/HttpUtils.dart';
import '../../../core/Shared.dart';
import '../../../core/Urls.dart';
import '../../../model/showKPIModel.dart';

class HomeController extends BaseController {
  int? currentIndex;
  late String? employeeType;
  LoginInfo? user;
  List<TabInfo> tabs = new List.empty(growable: true);
  RxList<ShowKPIModel> lstKPI = RxList.empty(growable: true);

  @override
  Future<void> onInit() async {
    await checkShowKPI().whenComplete(() => init());
    super.onInit();
  }

  Future<void> checkShowKPI() async {
    if(!await Utility.isInternetConnected()){
      alert(content: "Vui lòng bật internet.");
      return;
    }
    showEasyLoading();
    Map<String, dynamic> param = new Map();
    param["FUNCTION"] = 'SHOWKPI';
    param['WorkDate'] = DateTimes.today().toString();
    await HttpUtils.post(url: Urls.DOWNLOAD, body: param).then((value) {
      hideEasyLoading();
      if (value.statusCode == 200) {
        lstKPI.addAll(
            (value.content as List).map((e) => ShowKPIModel.fromJson(e)).toList());
        lstKPI.refresh();
      } else {
        alert(content: value.content.toString());
      }
    });
  }

  void init() async {
    user = await Shared.getUser();
    employeeType = (user!.typeid == 2 ? 'sup' : 'nv');
    tabs.add(new TabInfo(
        id: 0,
        title: 'Cửa hàng',
        icon: 'assets/icons/ic_shop.png',
        isSelected: false,
        backgroundColor: const Color(0xFF08D28B),
        iconColor: const Color(0xFF40A9FF),
        page: null));
    if(lstKPI.isNotEmpty && lstKPI[0].showOT == 1){
      tabs.add(new TabInfo(
          id: 1,
          title: 'Tăng ca',
          icon: 'assets/icons/ic_timesheet.png',
          isSelected: false,
          backgroundColor: const Color(0xFFFF6D65),
          iconColor: const Color(0xFFFF6D65),
          page: null));
    }
    if(lstKPI.isNotEmpty && lstKPI[0].showOT == 1){
      tabs.add(new TabInfo(
          id: 2,
          title: 'Nghỉ phép',
          icon: 'assets/icons/ic_timesheet.png',
          isSelected: false,
          backgroundColor: const Color(0xFFFF6D65),
          iconColor: const Color(0xFFFF6D65),
          page: null));
    }
    if (user!.typeid == 10) {
      tabs.add(new TabInfo(
          id: 1,
          title: 'Tăng ca',
          icon: 'assets/icons/ic_timesheet.png',
          isSelected: false,
          backgroundColor: const Color(0xFFFF6D65),
          iconColor: const Color(0xFFFF6D65),
          page: null));
      tabs.add(new TabInfo(
          id: 2,
          title: 'Nghỉ phép',
          icon: 'assets/icons/ic_timesheet.png',
          isSelected: false,
          backgroundColor: const Color(0xFFFF6D65),
          iconColor: const Color(0xFFFF6D65),
          page: null));
      tabs.add(new TabInfo(
          id: 3,
          title: 'E-Contact',
          icon: 'assets/icons/ic_timesheet.png',
          isSelected: false,
          backgroundColor: const Color(0xFFFF6D65),
          iconColor: const Color(0xFFFF6D65),
          page: null));
      tabs.add(new TabInfo(
          id: 4,
          title: 'Lương',
          icon: 'assets/icons/ic_timesheet.png',
          isSelected: false,
          backgroundColor: const Color(0xFFFF6D65),
          iconColor: const Color(0xFFFF6D65),
          page: null));
    }
    change(null, status: RxStatus.success());
  }

  void onMenuTap(TabInfo tabInfo) {
    switch (tabInfo.id) {
      case 0:
        Get.toNamed(Routes.SHOPLIST);
        break;
      case 1:
        Get.toNamed(Routes.MANAGEROT, arguments: employeeType);
        break;
      case 2:
        Get.toNamed(Routes.MANAGERLEAVE, arguments: employeeType);
        break;
      case 3:
        Get.toNamed(Routes.ECONTACT);
        break;
      case 4:
        Get.toNamed(Routes.SAlARY);
        break;
    }
  }
}
