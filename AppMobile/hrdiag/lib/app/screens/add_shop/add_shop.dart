import 'dart:ui';

import 'package:hr_diag/app/components/base_app_bar.dart';
import 'package:hr_diag/app/components/base_time_dropdown.dart';
import 'package:hr_diag/app/components/base_textfield.dart';
import 'package:hr_diag/app/core/AppStyle.dart';
import 'package:hr_diag/app/screens/add_shop/add_shop_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddShopView extends GetView<AddShopController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return controller.obx((state) => WillPopScope(
        child: Scaffold(
          appBar: BaseAppBar(
            title: Text('Tạo mới cửa hàng'),
            rightIsNotify: false,
            height: 50,
            isShowBackGround: false,
            leftIcon: Icons.arrow_back_ios,
            leftClick: () {
              controller.onBack();
            },
          ),
          body: Container(
            width: size.width,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    color: const Color(0xFFE5E5E5),
                    width: size.width,
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            child: VerticalDivider(
                              color: AppStyle.primary,
                              thickness: 5,
                            ),
                          ),
                          Text(
                            'Danh sách module',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  width: size.width,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '1. Tên chủ cửa hàng',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: BaseTextField(
                                  placeHolder: '',
                                  borderColor: const Color(0xFFD9D9D9),
                                  backgroundColor: const Color(0xFFF3F6FF),
                                  radius: 10,
                                  height: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '2. Số điện thoại',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: BaseTextField(
                                  placeHolder: '',
                                  borderColor: const Color(0xFFD9D9D9),
                                  backgroundColor: const Color(0xFFF3F6FF),
                                  radius: 10,
                                  height: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '3. Thành phố',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: BaseTimeDropDown(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '4. Quận',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: BaseTextField(
                                  placeHolder: '',
                                  borderColor: const Color(0xFFD9D9D9),
                                  backgroundColor: const Color(0xFFF3F6FF),
                                  radius: 10,
                                  height: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return controller.onBack();
        }));
  }
}
