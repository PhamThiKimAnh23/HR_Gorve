import 'package:hr_diag/app/components/base_app_bar.dart';
import 'package:hr_diag/app/components/base_textfield.dart';
import 'package:hr_diag/app/core/AppStyle.dart';
// import 'package:hr_diag/app/routers/app_routes.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'element/shop_item.dart';
import 'shop_list_controller.dart';

class ShopListView extends GetView<ShopListController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return Obx(() => WillPopScope(
        child: Scaffold(
          appBar: BaseAppBar(
            title: Text('Danh sách cửa hàng'),
            rightIsNotify: false,
            height: 50,
            isShowBackGround: false,
            leftIcon: Icons.arrow_back_ios,
            leftClick: () {
              controller.onBack();
            },
            //rightIcon: Icon(Icons.add),
            rightClick: () {},
          ),
          body: Container(
            width: size.width,
            child: Column(
              children: [
                Visibility(visible: false, child: Container(
                  width: size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: BaseTextField(
                            borderColor: Colors.grey[300],
                            backgroundColor: const Color(0xFFF3F6FF),
                            rightIcon: 'assets/icons/ic_search.png',
                            isPassword: false,
                            radius: 10,
                            height: 40,
                            placeHolder: 'Tìm kiếm...',
                            onChanged: (content) {},
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          width: 35,
                          height: 35,
                          child: Image.asset(
                            'assets/icons/ic_map.png',
                            color: AppStyle.primary,
                            fit: BoxFit.fill,
                          ),
                        ),
                        onTap: () {},
                      )
                    ],
                  ),
                )),
                Expanded(
                    child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.lstShop.length,
                  itemBuilder: (context, index) {
                    return ShopItem(
                      shop: controller.lstShop[index],
                      size: size,
                      index: index + 1,
                      lenght: controller.lstShop.length,
                      controller: controller,
                    );
                  },
                )),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return controller.onBack();
        }));
  }
}
