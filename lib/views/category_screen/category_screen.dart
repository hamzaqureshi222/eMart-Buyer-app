import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/product_controller.dart';
import 'package:emart/views/category_screen/category_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../consts/lists.dart';
import '../../widgets/bg_widget.dart';
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProductsController());
    return  bgWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: categories.text.white.fontFamily(semibold).make(),
        ),
        body:Container(
          width: context.screenWidth,
          height: context.screenHeight,
          padding:  const EdgeInsets.all(12),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 200,
              crossAxisCount: 3), itemBuilder: (context,index){
            return Column(
              children: [
                Image.asset(categoryImages[index],
                  height: context.screenHeight*0.15,
                  width: context.screenWidth*0.3,
                fit: BoxFit.cover),
                10.heightBox,
                "${categoriesList[index]}".text.color(darkFontGrey).align(TextAlign.center).make()
              ],
            ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().
            onTap(() {
              controller.getSubCategories(categoriesList[index]);
              Get.to(CategoryDetails(title: categoriesList[index]));});
          }),
        ),
      )
    );
  }
}
