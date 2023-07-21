import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hr_diag/app/model/off_model.dart';
import 'package:hr_diag/app/screens/leave/leave_controller.dart';

import '../../../core/Utility.dart';

class ItemLeave extends GetView<LeaveController>{
  final OffModel? info;

  ItemLeave(this.info);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          if (controller.employeeType == 'sup')
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(8),
                  color: const Color(0xFFFFFFFF),
                  child: Text(
                    !Utility.isNullOrWhiteSpace(info!.employeeName.toString()) ? info!.employeeName.toString() : '',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                )),
          if (controller.employeeType == 'sup')
            Divider(
              color: const Color(0xFFEBEBEB),
              indent: 2,
            ),
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                color: const Color(0xFFFFFFFF),
                child: Text(
                  !Utility.isNullOrWhiteSpace(info!.oFFDate.toString()) ? info!.oFFDate.toString() : '',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              )),
          Divider(
            color: const Color(0xFFEBEBEB),
            indent: 2,
          ),
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                color: const Color(0xFFFFFFFF),
                child: Text(
                  !Utility.isNullOrWhiteSpace(info!.oFFTypeName.toString()) ? info!.oFFTypeName.toString() : '',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              )),
          Divider(
            color: const Color(0xFFEBEBEB),
            indent: 2,
          ),
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                color: const Color(0xFFFFFFFF),
                child: Text(
                  !Utility.isNullOrWhiteSpace(info!.offValue.toString()) ? info!.offValue.toString() : '',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              )),
          Divider(
            color: const Color(0xFFEBEBEB),
            indent: 2,
          ),
          Expanded(
              flex: 2,
              child: Container(
                  padding: EdgeInsets.all(5),
                  color: const Color(0xFFFFFFFF),
                  child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: info!.status == 0
                                  ? Colors.red.shade700
                                  : info!.status == 2
                                  ? Colors.yellow.shade700
                                  : Colors.green.shade700),
                          borderRadius: BorderRadius.all(
                              Radius.circular(20)),
                          color: info!.status == 0
                              ? Colors.red.shade100
                              : info!.status == 2
                              ? Colors.yellow.shade100
                              : Colors.green.shade100),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(
                                    Radius.circular(
                                        100)),
                                color: info!.status == 0
                                    ? Colors.red.shade700
                                    : info!.status == 2
                                    ? Colors.yellow.shade700
                                    : Colors.green.shade700),
                          ),
                          Text(
                            !Utility.isNullOrWhiteSpace(info!.statusName.toString()) ? info!.statusName.toString(): '',
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(fontSize: 12),
                          ),
                        ],
                      )))),
        ],
      ),
      onTap: () {
        controller.toDetail(info!);
      },
    );
  }

}