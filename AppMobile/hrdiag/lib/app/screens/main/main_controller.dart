import 'dart:io';

import 'package:hr_diag/app/base/TabInfo.dart';
import 'package:hr_diag/app/screens/main/account/account.dart';
import 'package:get/get.dart';
import '../../base/LoginInfo.dart';
import '../../base_controller.dart';
import '../../core/Shared.dart';
import 'home/home.dart';

class MainController extends BaseController {
  List<TabInfo>? tabs;
  int currentIndex = 0;
  RxString employeeName = ''.obs;
  RxString avatar = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    LoginInfo? user = await Shared.getUser();
    employeeName.value = user != null ? user.employeeName : '';
    avatar.value =  user != null ? user.avatar : '';
    init();
  }

  Future<void> init() async {
    if (tabs == null) {
      tabs = new List.empty(growable: true);
      tabs!.add(new TabInfo(
          id: 0,
          title: 'Trang chủ',
          icon: 'assets/icons/ic_home.png',
          isSelected: true,
          page: HomeView()));
      tabs!.add(new TabInfo(
          id: 0,
          title: 'Tài khoản',
          icon: 'assets/icons/ic_user.png',
          isSelected: true,
          page: AccountView()));
    }
    change(null, status: RxStatus.success());
  }

  String getPageName() {
    return tabs![currentIndex].title!;
  }

  void changeTab(int index) {
    this.currentIndex = index;
    tabs!.forEach((element) {
      if (element.id == currentIndex) {
        element.isSelected = true;
      } else {
        element.isSelected = false;
      }
    });
    change(null, status: RxStatus.success());
  }

  Future<bool> onBack() async {
    if (currentIndex != 0) {
      currentIndex = 0;
      tabs!.forEach((element) {
        if (element.id == currentIndex) {
          element.isSelected = true;
        } else {
          element.isSelected = false;
        }
      });
      change(null, status: RxStatus.success());
    } else {
      confirm(
          content: "Bạn có muốn thoát ứng dụng không? ",
          onConfirm: () {
            exit(0);
          },
          onCancel: () {
            Get.back();
          });
    }
    return false;
  }
}
