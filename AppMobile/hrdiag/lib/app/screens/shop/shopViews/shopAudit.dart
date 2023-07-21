

import 'package:hr_diag/app/base/MasterInfo.dart';
// import 'package:hr_diag/app/base/ShopInfo.dart';
import 'package:hr_diag/app/components/base_textfield.dart';
import 'package:hr_diag/app/core/Utility.dart';
import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_diag/app/extensions/ExsString.dart';
import '../shop_controller.dart';

class ShopAudit extends GetView<ShopController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          color: Colors.white,
          width: Utility.getWidthScreen(context),
          height: Utility.getHeightScreen(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [checkInOut()],
          ),
        )));
  }

  Widget secondLayout() {
    return Expanded(
        child: Container(
      color: const Color(0xFFF9F9F9),
      padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [shopStatus(), listKPI()],
      ),
    ));
  }

  Widget checkInOut() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 104),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LimitedBox(
                maxHeight: 100,
                maxWidth: 140,
                child: DottedBorder(
                    color: const Color(0xFF40A9FF),
                    strokeWidth: 1,
                    dashPattern: [
                      1,
                      2,
                    ],
                    // ignore: unnecessary_null_comparison
                    child: controller.lstAttendants != null &&
                            controller.lstAttendants.length >= 1 &&
                            controller.lstAttendants[0].attendantType == 0 &&
                            !ExString(controller.imageCheckInPath.value)
                                .isNullOrWhiteSpace()
                        ? Padding(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.network(
                                  controller.imageCheckInPath.value,
                                  fit: BoxFit.contain,
                                  alignment: Alignment.center,
                                  width: 140,
                                  height: 104,
                                )))
                        : InkWell(
                            child: Container(
                              width: 140,
                              height: 104,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE6F7FF),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_rounded,
                                    color: const Color(0xFF40A9FF),
                                    size: 30,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Check in",
                                    style: TextStyle(
                                        color: const Color(0xFF40A9FF),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ],
                              ),
                            ),
                            onTap: () => controller.startCamera(0)))),
            LimitedBox(
                maxHeight: 100,
                maxWidth: 140,
                child: DottedBorder(
                    color: const Color(0xFF40A9FF),
                    strokeWidth: 1,
                    dashPattern: [
                      1,
                      2,
                    ],
                    // ignore: unnecessary_null_comparison
                    child: controller.lstAttendants != null &&
                            controller.lstAttendants.length >= 2 &&
                            controller.lstAttendants[1].attendantType == 1 &&
                            !ExString(controller.imageCheckOutPath.value)
                                .isNullOrWhiteSpace()
                        ? Padding(
                            padding: EdgeInsets.all(2),
                            child: Image.network(
                              controller.imageCheckOutPath.value,
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                              width: 140,
                              height: 104,
                            ))
                        : InkWell(
                            child: Container(
                              width: 140,
                              height: 104,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE6F7FF),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_rounded,
                                    color: const Color(0xFF40A9FF),
                                    size: 30,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Check out",
                                    style: TextStyle(
                                        color: const Color(0xFF40A9FF),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ],
                              ),
                            ),
                            onTap: () => controller.startCamera(1),
                          ))),
          ],
        ),
      ),
    );
  }

  Widget shopStatus() {
    return Container(
      width: Utility.getWidthScreen(Get.context!),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "Trạng thái CH: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Visibility(
                    visible: false,
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: const Color(0xFFD9D9D9)),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        )),
                        child: DropdownButton<MasterInfo>(
                            underline: SizedBox(),
                            isDense: true,
                            value: controller.masterInfo.value,
                            items: controller.lstMaster.map((MasterInfo value) {
                              return DropdownMenuItem<MasterInfo>(
                                value: value,
                                child: Text(value.name),
                              );
                            }).toList(),
                            isExpanded: true,
                            onChanged: !controller.work!.value.locked
                                ? null /*(MasterInfo value) async {
                                controller.selectedDropdownButtonHandler(
                                    shop, value);
                              }*/
                                : null))),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget listKPI() {
    // ignore: unnecessary_null_comparison
    return controller.lstKPI != null && controller.lstKPI.length != 0
        ? Expanded(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ListView.builder(
                    itemCount: controller.lstKPI.length,
                    itemBuilder: (BuildContext buildContext, int index) {
                      return itemKPI(controller.lstKPI[index]);
                    })))
        // ignore: unnecessary_null_comparison
        : controller.work!.value.auditResult != null &&
                controller.work!.value.auditResult != 0 &&
                controller.work!.value.auditResult != 1
            ? Expanded(
                flex: 1,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  children: [
                    Container(
                      height: 100,
                      margin: EdgeInsets.only(top: 20, bottom: 80),
                      child: BaseTextField(
                        enabled: !controller.work!.value.locked,
                        radius: 5,
                        textInputType: TextInputType.multiline,
                        maxLines: 3,
                        borderColor: const Color(0xFFE0E0E0),
                        placeHolder: 'Ghi chú...',
                        controller: controller.controllerComment,
                        focusNode: controller.focusNodeComment,
                        onChanged: (content) {
                          // if (controller.timeHandle != null) {
                          //   controller.timeHandle.cancel();
                          // }
                          // controller.timeHandle =
                          //     Timer(Duration(milliseconds: 200), () async {
                          //   controller.work.value.comment = content;
                          //   controller.setComment(controller.work.value);
                          // });
                        },
                      ),
                    )
                  ],
                ))
            : Center();
  }

  Widget itemKPI(MasterInfo kpi) {
    return InkWell(
      onTap: () => null /*controller.toScreen(shop, kpi)*/,
      child: Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(2, 5, 5, 2),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 80),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Expanded(
                              flex: 1,
                              child: Text(
                                kpi.code,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                kpi.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF888888)),
                              ))
                        ],
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 30),
                      child: Container(
                        decoration: BoxDecoration(
                            color: kpi.kpiStatus == 2
                                ? const Color(0xFFF6FFED)
                                : kpi.kpiStatus == 1
                                    ? const Color(0xFFFEFFE6)
                                    : const Color(0xFFFFFFFF),
                            border: Border.all(
                                color: kpi.kpiStatus == 2
                                    ? const Color(0xFFB7EB8F)
                                    : kpi.kpiStatus == 1
                                        ? const Color(0xFFFFF566)
                                        : const Color(0xFFD9D9D9)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.circle_rounded,
                              color: kpi.kpiStatus == 2
                                  ? const Color(0xFFB7EB8F)
                                  : kpi.kpiStatus == 1
                                      ? const Color(0xFFFFF566)
                                      : const Color(0xFFD9D9D9),
                              size: 7,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              kpi.kpiStatus == 2
                                  ? " Hoàn thành"
                                  : kpi.kpiStatus == 1
                                      ? " Đang làm"
                                      : " Khảo sát",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 35,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: const Color(0xFFBBBBBB),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
