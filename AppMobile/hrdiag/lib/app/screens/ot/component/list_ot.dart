// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hr_diag/app/screens/ot/component/list_ot_item.dart';
import 'package:hr_diag/app/screens/ot/ot_controller.dart';

// import '../../../core/Utility.dart';

class ListOT extends GetView<OTController>{
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Obx(() => controller.lstDataOT.isNotEmpty ? ListView.builder(shrinkWrap: false, itemCount: controller.lstDataOT.length,itemBuilder: (buildContext, index){
        return ItemOT(controller.lstDataOT[index]);
      },): Center(child: Image.network('https://diag.e-technology.vn/nodata.png',scale: 0.8,width: 200,height: 200,errorBuilder: (buildContext,object, stacktrace){
        return Center(child: Icon(Icons.error_rounded,color: Colors.red.shade700,size: 50,),);
      },),),
    ));
  }
  
}