import 'package:hr_diag/app/base/TabInfo.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MenuItem extends StatelessWidget {
  TabInfo? tabInfo;
  Size? size;
  MenuItem({this.tabInfo, this.size});
  @override
  Widget build(BuildContext context) {
    double itemsize = this.size!.width / 3;
    return Container(
      width: itemsize,
      height: itemsize,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(20),
              color: tabInfo!.backgroundColor!.withOpacity(0.2),
              child: Image.asset(
                tabInfo!.icon!,
                width: 35,
                height: 35,
                color: tabInfo!.iconColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Text(
              tabInfo!.title!,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
