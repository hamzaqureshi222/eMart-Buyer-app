import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../consts/styles.dart';

Widget LoginButton({onPress,color,textColor,String? title}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color,padding: const EdgeInsets.all(12)),
      onPressed: onPress, child: title?.text.color(textColor).fontFamily(bold).make());
}