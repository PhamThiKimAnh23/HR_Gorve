import 'dart:async';

import 'package:hr_diag/app/base/ShopInfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base_controller.dart';
import '../../core/HttpUtils.dart';
import '../../core/Urls.dart';
import '../../routers/app_routes.dart';

class ShopListController extends BaseController {
  TextEditingController searchController = new TextEditingController();
  Timer? timeHandle;

  RxList<ShopInfo> lstShop = RxList.empty(growable: true);
  @override
  Future<void> onInit() async {
    super.onInit();
    downloadShop();
  }

  Future<void>downloadShop() async {
    showEasyLoading();
    lstShop.clear();
    Map<String, String> param = new Map();
    param["FUNCTION"] = "SHOPS";
    await HttpUtils.post(url: Urls.DOWNLOAD,
        body: param).then((value){
      hideEasyLoading();
      if (value.statusCode == 200) {
        lstShop.addAll((value.content as List).map((e) => ShopInfo.fromJson(e)).toList());
      }else{
        alert(content: value.content.toString());
      }
    });
  }

  bool onBack() {
    Get.back();
    return false;
  }

  @override
  void onClose() {
    super.onClose();
  }

  toShop(ShopInfo shop) {
    Get.toNamed(Paths.SHOP,
        arguments: <dynamic>[shop], preventDuplicates: false)!.then((value) async {
       await downloadShop();
    });
  }
}
