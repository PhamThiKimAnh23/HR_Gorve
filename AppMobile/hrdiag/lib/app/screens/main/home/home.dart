import 'package:hr_diag/app/core/AppStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'elements/menu_item.dart' as mcu;
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return controller.obx((state) => Container(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Container(
                  width: size.width,
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          height: 35,
                          child: VerticalDivider(
                            color: AppStyle.primary,
                            thickness: 5,
                          ),
                        ),
                        Text(
                          'Danh sách công việc',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  child: Container(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 7,
                      crossAxisCount: 3),
                  itemBuilder: (_, index) => InkWell(
                    child: mcu.MenuItem(
                      tabInfo: controller.tabs[index],
                      size: size,
                    ),
                    onTap: () {
                      controller.onMenuTap(controller.tabs[index]);
                    },
                  ),
                  itemCount: controller.tabs.length,
                ),
              )),
            ],
          ),
        ));
  }
}
