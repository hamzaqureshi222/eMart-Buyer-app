import 'package:emart/consts/consts.dart';
import 'package:emart/views/category_screen/category_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Widget featuredButton({icon,String? title}){
  return  Row(
    children: [
      Image.asset(icon,width: 60,fit: BoxFit.fill,),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.white.width(200).margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.
  padding(const EdgeInsets.all(4)).shadowSm.make().onTap(() {
    Get.to(CategoryDetails(title: title));
  });
}