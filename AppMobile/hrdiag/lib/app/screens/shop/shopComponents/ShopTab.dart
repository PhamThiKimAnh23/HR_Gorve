import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopTab {
  Widget tabBar({TabController? tabController, List<String>? lst, Color? hexColor}) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          border: Border.all(color: hexColor!, width: 1)),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: EdgeInsets.all(0),
        indicatorPadding: EdgeInsets.all(0),
        controller: tabController,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        indicator: BoxDecoration(
          color: hexColor,
        ),
        tabs: [
          Container(
              width: 300,
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(
                          color: hexColor, width: 1))),
              child: Tab(
                child: Text(
                  lst![0],
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              )),
          Container(
              width: 300,
              child: Tab(
                child: Text(
                  lst[1],
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              )),
          // Container(
          //     width: 300,
          //     decoration: BoxDecoration(
          //         border: Border(
          //             left: BorderSide(
          //                 color: hexColor, width: 1))),
          //     child: Tab(
          //       child: Text(
          //         lst[2],
          //         style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          //       ),
          //     )),
        ],
      ),
    );
  }
}
