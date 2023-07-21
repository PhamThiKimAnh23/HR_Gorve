import 'package:flutter/cupertino.dart';

class TabInfo {
  int? id;
  String? title;
  String? icon;
  bool? isSelected;
  Color? backgroundColor;
  Color? iconColor;
  Widget? page;
  TabInfo({this.id, this.title, this.icon, this.isSelected, this.page,this.backgroundColor,this.iconColor});
}
