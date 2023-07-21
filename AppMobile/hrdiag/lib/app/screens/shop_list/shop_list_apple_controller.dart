import 'dart:async';
import 'package:hr_diag/app/base/LoginInfo.dart';
import 'package:hr_diag/app/base/ShopInfo.dart';
import 'package:hr_diag/app/base/TabInfo.dart';
import 'package:hr_diag/app/core/HttpResponseMessage.dart';
import 'package:hr_diag/app/core/HttpUtils.dart';
import 'package:hr_diag/app/core/Shared.dart';
import 'package:hr_diag/app/core/Urls.dart';
import 'package:hr_diag/app/routers/app_routes.dart';
import 'package:hr_diag/app/screens/main/account/account.dart';
import 'package:hr_diag/app/screens/shop_list/shop_list_apple.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../base_controller.dart';

class ShopListAppleController extends BaseController {
  TextEditingController searchController = new TextEditingController();
  Timer? timeHandle;

  List<ShopInfo> lstShop = new List.empty(growable: true);
  List<TabInfo>? tabs;
  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    for (int i = 0; i <= 9; i++) {
      ShopInfo shop = new ShopInfo(
          shopId: i + 1,
          shopName: 'Store ' + (i +1).toString(),
          contactName: "Store " + i.toString(),
          address: 'Work Address',
          photo:
              'https://d5nunyagcicgy.cloudfront.net/external_assets/hero_examples/hair_beach_v391182663/original.jpeg',
          phone: '090112233',
          orderPending: 1,
          oosAchieve: 32,
          sosAchieve: 45);
      lstShop.add(shop);
    }
    if (tabs == null) {
      tabs = new List.empty(growable: true);
      tabs!.add(new TabInfo(
          id: 0,
          title: 'Home',
          icon: 'assets/icons/ic_home.png',
          isSelected: true,
          page: ShopListAppleView()));
      tabs!.add(new TabInfo(
          id: 1,
          title: 'Logout',
          icon: 'assets/icons/ic_user.png',
          isSelected: false,
          page: AccountView()));
      tabs!.add(new TabInfo(
          id: 2,
          title: 'Clear Account & Data',
          icon: 'assets/icons/ic_user.png',
          isSelected: false,
          page: AccountView()));
    }
    change(null, status: RxStatus.success());
  }

  bool onBack() {
    Get.back();
    return false;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeTab(TabInfo ti) {
   if(ti.id ==1)
     {
       confirmApple(
           content: "Do you want to log out of the application ?",
           onConfirm: () async {
             await Shared.setUser(null);
             Get.offAllNamed(Routes.LOGIN);
           },
           onCancel: () {
             Navigator.of(Get.context!).pop();
           });
     }
   if(ti.id ==2)
   {
     confirmApple(
         content: "Do you want to delete your account and all your data?",
         onConfirm: () async {
           LoginInfo? user = await Shared.getUser();
           HttpResponseMessage response =
           HttpResponseMessage(statusCode: 202, content: "Start send...");
           Map<String, String> param = new Map();
           param["FUNCTION"] = "APPLE_EMPLOYEE";
           param["ActionType"] = "3";
           param["Email"] = user!.loginName;
           response = await HttpUtils.post(body: param, url: Urls.UPLOAD_FILE);
           print(response.statusCode.toString() + '-' + response.content.toString());
           if (response.statusCode == 200) {
             await Shared.setUser(null);
             Get.offAllNamed(Routes.LOGIN);
           }
         },
         onCancel: () {
           Navigator.of(Get.context!).pop();
         });
   }
  }

  void confirmApple(
      {String title = 'Message',
        required String content,
        VoidCallback? onConfirm,
        VoidCallback? onCancel}) {
    Get.defaultDialog(
        title: title,
        titleStyle: TextStyle(color: Colors.black, fontSize: 18),
        middleText: content,
        middleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        radius: 10,
        barrierDismissible: false,
        buttonColor: Colors.white,
        textConfirm: 'Yes',
        textCancel: 'Cancel',
        cancelTextColor: Colors.red[500],
        confirmTextColor: Colors.blue[500],
        onConfirm: onConfirm != null
            ? onConfirm
            : () {
          Get.back();
        },
        onCancel: onCancel);
  }
}
