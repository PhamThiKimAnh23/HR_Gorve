import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';

class CountContainer extends StatelessWidget{
  final String? title1;
  final String? title2;
  final Color? colorIconTitle;
  final Color? colorBackgroundIcon;
  final IconData? icon;

  CountContainer({this.title1, this.title2, this.colorIconTitle,this.colorBackgroundIcon,this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFB),
        border: Border.all(color: colorBackgroundIcon!),borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
        decoration: BoxDecoration(
          color: colorBackgroundIcon,
          border: Border.all(color: colorBackgroundIcon!),borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Icon(icon,color: colorIconTitle,),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(title1!,style: TextStyle(fontWeight: FontWeight.bold,color: colorIconTitle,fontSize: 20),),),
      Container(
          padding: EdgeInsets.only(left: 5,bottom: 1,top: 5),child: Text(title2!,style: TextStyle(fontSize: 15),),)
        ],
      ),
    );
  }

}