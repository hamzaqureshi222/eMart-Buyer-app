import 'package:emart/consts/consts.dart';
import 'package:flutter/cupertino.dart';

Widget HomeButton({width,height,icon,String? title,onPress}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon,width: 26),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.rounded.size(width, height).white.make();
}