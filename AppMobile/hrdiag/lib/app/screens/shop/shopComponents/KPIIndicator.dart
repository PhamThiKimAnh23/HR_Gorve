// import 'package:hr_diag/app/core/Utility.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KPIIndicator extends StatelessWidget{
  final String? name;
  final String? percent;
  final double? value;
  final Color? color;
  final double? size;

  KPIIndicator({this.name,this.percent,this.value,this.color,this.size});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          width: size,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child:Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: color != null ? color : Colors.white,
                      radius: 4,
                    ),
                    SizedBox(width: 5,),
                    Text(name!,style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                )
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(percent!,style: TextStyle(fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
        Container(
          height: 10,
          child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10)),child: LinearProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(color!,),
            value: value,
          ),
        ))
      ],
    );
  }

}