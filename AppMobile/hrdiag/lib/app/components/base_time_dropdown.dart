//import 'dart:isolate';

import 'package:hr_diag/app/base/DropDownItem.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BaseTimeDropDown extends StatefulWidget {
  final DropDownItem? value;
  final List<DropDownItem>? data;
  bool isLocked;
  double height;
  Function(DropDownItem value)? function;
  BaseTimeDropDown(
      {this.data, this.value, this.isLocked = false, this.height = 30,this.function});
  @override
  State<StatefulWidget> createState() {
    return BaseTimeDropDownState();
  }
}

class BaseTimeDropDownState extends State<BaseTimeDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.white,
      ),
      child: DropdownButton<DropDownItem>(
        disabledHint: !widget.isLocked
            ? null
            : Text(
                widget.value!.lable,
                style: TextStyle(fontSize: 13),
              ),
        isExpanded: true,
        value: widget.value,
        icon: Container(
          child: Icon(Icons.calendar_today_outlined,color: Colors.grey,
          ),
        ),
        iconSize: 30,
        underline: SizedBox(),
        onChanged: !widget.isLocked ? (DropDownItem? newValue) async {
          this.widget.function!(newValue!);
        } : null,
        items: widget.data!
            .map<DropdownMenuItem<DropDownItem>>((DropDownItem value) {
          return DropdownMenuItem<DropDownItem>(
            value: value,
            child: Container(
              child: Text(
                value.lable,
                style: TextStyle(fontSize: 13, color: Colors.black),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
