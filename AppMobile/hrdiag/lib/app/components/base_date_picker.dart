// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseDatePicker extends StatelessWidget {
  String? date;
  double? width;
  double? height;
  double? borderRadius;
  VoidCallback? onTap;
  BaseDatePicker(
      {this.date = 'Select date',
      this.width,
      this.height,
      this.borderRadius: 10,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius!),
          border: Border.all(
            color: Colors.grey,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.white,
        ),
        width: width,
        height: height,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                child: Text(
                  date!,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Image.asset(
                  'assets/icons/ic_calendar.png',
                  width: 30,
                  height: 30,
                ),
              ),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
