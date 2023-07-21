// import 'package:hr_diag/app/core/Utility.dart';
import 'package:hr_diag/app/screens/leave/leave_controller.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';

class ChooseDateTime extends GetView<LeaveController> {
  final double? height;
  final String? hint;

  ChooseDateTime({this.height, this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: InkWell(child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child:
             Text(
                hint!,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.calendar_today_outlined,color: Colors.grey,),
            )
          ],
        ),onTap: (){
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(2022, 1, 1),
              maxTime: DateTime(2025, 12, 31), onConfirm: (date) {
                controller.setDate(date);
              }, currentTime: controller.date!.value, locale: LocaleType.en);
        },));
  }
}
