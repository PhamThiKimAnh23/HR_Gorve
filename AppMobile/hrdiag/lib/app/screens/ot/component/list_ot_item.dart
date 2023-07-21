import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hr_diag/app/core/Utility.dart';
import 'package:hr_diag/app/extensions/ExsString.dart';
import 'package:hr_diag/app/model/ot_model.dart';
import 'package:hr_diag/app/screens/ot/ot_controller.dart';

import '../../../core/AppStyle.dart';

class ItemOT extends GetView<OTController> {
  final OTModel info;

  ItemOT(this.info);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        width: Utility.getWidthScreen(context),
        height: 50,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Visibility(
                    visible: controller.employeeType == 'sup',
                    child: Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        child: Text(
                          !ExString(info.employeeName.toString()).isNullOrWhiteSpace()
                              ? info.employeeName.toString()
                              : 'demo',
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    )),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/ic_calendar2.png',
                          width: 20,
                          height: 20,
                          color: AppStyle.primary,
                        ),
                        Expanded(
                            child: Text(
                          info.oTDate.toString(),
                          style:
                              TextStyle(color: AppStyle.primary, fontSize: 13),
                        ))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      info.oTTargetName.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      info.oTValue.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: info.status == 0
                            ? Colors.red.shade100
                            : info.status == 2
                                ? Colors.yellow.shade100
                                : Colors.green.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: AppStyle.primary,
                        )),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          width: 10,
                          height: 10,
                          child: Image.asset('assets/icons/ic_dot.png',
                              color: info.status == 0
                                  ? Colors.red.shade700
                                  : info.status == 2
                                      ? Colors.yellow.shade700
                                      : Colors.green.shade700),
                        ),
                        Expanded(
                            child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            info.statusName.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        controller.onViewOTTap(info);
      },
    );
  }
}
