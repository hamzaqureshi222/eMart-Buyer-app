import 'package:emart/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget orderStatus({icon,color,title,showDone}){
  return ListTile(
    leading: Icon(icon,color: color,).box.roundedSM.padding(const EdgeInsets.all(4)).border(color: color).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "$title".text.color(darkFontGrey).make(),
          showDone?const Icon(Icons.done_all,color: redColor,):Container()
        ],
      ),
    ),
  );
}