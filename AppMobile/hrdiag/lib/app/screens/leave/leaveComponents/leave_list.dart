import 'package:flutter/cupertino.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hr_diag/app/screens/leave/leave_controller.dart';

import 'leave_list_item.dart';

class LeaveList extends GetWidget<LeaveController>{
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(itemCount: controller.lstDataOff.length, itemBuilder: (buildContext, index){
      return ItemLeave(controller.lstDataOff[index]);
    },));
  }
  
}