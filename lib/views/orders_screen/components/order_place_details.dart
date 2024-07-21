import 'package:emart/consts/consts.dart';
import 'package:flutter/cupertino.dart';

Widget orderPlaceDetails({title1,title2,d1,d2}){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
      children: [
        Column(
          children: [
            '$title1'.text.semiBold.make(),
            '$d1'.text.color(redColor).semiBold.make()
          ],
        ),
        Column(
          children: [
            '$title2'.text.semiBold.make(),
            '$d2'.text.color(redColor).semiBold.make()
          ],
        ),
      ],
    ),
  );
}