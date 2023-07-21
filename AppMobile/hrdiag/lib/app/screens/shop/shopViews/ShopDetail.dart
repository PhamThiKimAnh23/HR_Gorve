// ignore_for_file: unnecessary_null_comparison

import 'package:hr_diag/app/core/AppStyle.dart';
// import 'package:hr_diag/app/core/FileUtils.dart';
import 'package:hr_diag/app/screens/shop/shopComponents/KPIIndicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:hr_diag/app/extensions/ExsString.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../shop_controller.dart';

class ShopDetail extends GetView<ShopController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() => Container(
          height: size.width,
          width: size.height,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/ic_full_selection.png',
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Tên chủ CH',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: DottedBorder(
                        color: AppStyle.primary,
                        radius: Radius.circular(20),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                          constraints: BoxConstraints(maxWidth: 250, minWidth: 200),
                          color: const Color(0xFFE6F7FF),
                          child: Text(
                            controller.shop! != null && controller.shop!.shopName!.isNullOrWhiteSpace()
                                ? ''
                                : controller.shop!.shopName.toString(),
                            style: TextStyle(overflow: TextOverflow.ellipsis,
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(color: Colors.grey),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Số điện thoại',
                          style: TextStyle(
                              fontSize: 15, color: AppStyle.text_base_Color)),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Row(
                          children: [
                            Text(controller.shop != null &&
                                    controller.shop!.phone!.isNullOrWhiteSpace()
                                ? ''
                                : controller.shop!.phone.toString()),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              child: Image.asset(
                                'assets/icons/ic_phone.png',
                                width: 35,
                                height: 35,
                              ),
                              onTap: () {
                                controller
                                    .callWitiPhoneNumner(controller.shop!.phone!);
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(color: Colors.grey),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Địa chỉ',
                          style: TextStyle(
                              fontSize: 15, color: AppStyle.text_base_Color)),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              controller.shop != null &&
                                      controller.shop!.address!
                                          .isNullOrWhiteSpace()
                                  ? ''
                                  : controller.shop!.address.toString(),
                              textAlign: TextAlign.right,
                            ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey),
              Visibility(
                  visible: false,
                  child: Container(
                    height: 90,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: KPIIndicator(
                              name: 'OOS',
                              percent: '35%',
                              value: 0.35,
                              color: Colors.red,
                              size: size.width / 2,
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: KPIIndicator(
                              name: 'SOS',
                              percent: '58%',
                              value: 0.58,
                              color: Colors.blue,
                              size: size.width / 2,
                            )),
                      ],
                    ),
                  )),
              Divider(color: Colors.grey),
              Container(
                  padding: EdgeInsets.all(10),
                  width: size.width,
                  height: 200,
                  child: controller.shop != null ? photoView() : Center()),
              Visibility(
                  visible: true,
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: size.width,
                      height: 200,
                      child: DottedBorder(
                        color: AppStyle.primary,
                        radius: Radius.circular(20),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: const Color(0xFFF6FFED),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image.asset(
                                'assets/icons/ic_camera.png',
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Chụp hình overview',
                                style: TextStyle(
                                    color: AppStyle.primary, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () => !controller.work!.value.locked
                        ? controller.startCamera(1000)
                        : null,
                  ))
            ],
          )),
        ));
  }

  Widget photoView() {
    if (controller.overview.value == null) {
      if (!controller.shop!.photo!.isNullOrWhiteSpace()) {
        return CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: controller.shop!.photo!,
          placeholder: (context, url) => Container(
            padding: EdgeInsets.all(10),
            child: Container(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        );
      } else {
        return SizedBox();
      }
    } else {
      if (!ExString(controller.overview.value.photoServer)
          .isNullOrWhiteSpace()) {
        if (!controller.overview.value.photoServer.isNullOrWhiteSpace()) {
          return CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: controller.overview.value.photoServer,
            placeholder: (context, url) => Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          );
        } else {
          return SizedBox();
        }
      } else {
        if (!controller.shop!.photo!.isNullOrWhiteSpace()) {
          return CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: controller.shop!.photo!,
            placeholder: (context, url) => Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          );
        } else {
          return SizedBox();
        }
      }
    }
  }
}
