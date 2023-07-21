// import 'package:hr_diag/app/base/ShopInfo.dart';
// import 'package:hr_diag/app/base/WorkResultInfo.dart';
import 'package:hr_diag/app/components/base_app_bar.dart';
import 'package:hr_diag/app/core/Utility.dart';
import 'package:hr_diag/app/screens/shop/shopComponents/ShopTab.dart';
import 'package:hr_diag/app/screens/shop/shopViews/ShopDetail.dart';
import 'package:hr_diag/app/screens/shop/shopViews/shopAudit.dart';
import 'package:hr_diag/app/screens/shop/shop_controller.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Shop extends GetView<ShopController> {
  @override
  Widget build(BuildContext context) {
    //Size size = Get.mediaQuery.size;
    return WillPopScope(
          onWillPop: () => controller.onBackPress(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: BaseAppBar(
              title: Text('Thông tin cửa hàng'),
              rightIsNotify: false,
              isShowBackGround: false,
              leftIcon: Icons.arrow_back_ios_new,
              leftClick: controller.onBackPress,
              //rightIcon: Icon(Icons.mic_none_rounded),
              //rightClick: () => null//controller.onRecord(shop),
            ),
            body: shopBody(),
          ),
        );
  }

  Widget shopBody() {
    return Container(
      height: Utility.getHeightScreen(Get.context!),
      width: Utility.getWidthScreen(Get.context!),
      color: Colors.white,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  padding: EdgeInsets.fromLTRB(70, 20, 70, 0),
                  child: ShopTab().tabBar(
                      tabController: controller.tabController,
                      lst: controller.lst,
                      hexColor: Color(0xFF40A9FF)))),
          Align(
            alignment: Alignment.center,
            child: Container(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: controller.tabController,
                      children: [ShopDetail(), ShopAudit()],
                    ))),
          ),
        ],
      ),
    );
  }
}
