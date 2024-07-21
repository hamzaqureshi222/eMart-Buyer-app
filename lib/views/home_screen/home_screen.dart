import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/home_controller.dart';
import 'package:emart/views/category_screen/item_details.dart';
import 'package:emart/views/home_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../consts/lists.dart';
import '../../services/firestore_services.dart';
import '../../widgets/featured_button.dart';
import '../../widgets/home_buttons.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<HomeController>();
    return  Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 55,
            color: lightGrey,
            child: TextFormField(
              controller: controller.searchController,
              decoration:  InputDecoration(
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                suffixIcon: const Icon(Icons.search).onTap(() {
                  if(controller.searchController.text.isNotEmptyAndNotNull){
                  Get.to( SearchScreen(title: controller.searchController.text,));
                  }
                }),
                fillColor: whiteColor,
              filled: true,
                hintText:search,
                hintStyle: const TextStyle(color: textfieldGrey)
              ),
            )
          ),
          10.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: SLidersList.length, itemBuilder: (context,index){
                    return Container(
                        child: Image.asset(SLidersList[index],fit: BoxFit.fill,
                        ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make()
                    );
                  }),
                  20.heightBox,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(2, (index) => HomeButton(
                          height: context.screenHeight*0.15,width: context.screenWidth/2.5,
                          icon: index==0?icTodaysDeal : icFlashDeal,
                          title: index==0?todaydeal:flashsale
                      ))
                  ),
                  15.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      height: 150,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      autoPlay: true,
                      enlargeCenterPage: true,
                      itemCount: SecondSLidersList.length, itemBuilder: (context,index){
                    return Container(
                        child: Image.asset(SecondSLidersList[index],fit: BoxFit.fill,
                        ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make()
                    );
                  }),
                  10.heightBox,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(3, (index) => HomeButton(
                          height: context.screenHeight*0.13,width: context.screenWidth/3.6,
                          icon: index==0?icTopCategories :index==1?icBrands:icTopSeller,
                          title: index==0?topCategories :index==1?brand:topsellers
                      ))
                  ),
                  20.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: featurecategories.text.color(darkFontGrey).size(17).fontFamily(semibold).make()),
                  15.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:List.generate(3, (index) => Column(
                          children: [
                            featuredButton(icon: featuredImages1[index],title: featuredTitle1[index]),
                            10.heightBox,
                            featuredButton(icon: featuredImages2[index],title: featuredTitle2[index]),
                          ],
                        ))
                    ),
                  ),
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: redColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProduct.text.white.fontFamily(bold).make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder(
                            future: FirestoreServices.getFeaturedProducts(),
                            builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
                              if(!snapshot.hasData){
                                return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),);
                              }else if(snapshot.data!.docs.isEmpty){
                                return 'No Featured Products'.text.white.makeCentered();
                              }else{
                                var featuredData=snapshot.data!.docs;
                                return Row(
                                    children: List.generate(featuredData.length, (index) =>  GestureDetector(
                                      onTap: (){
                                        Get.to(ItemDetails(title: featuredData[index]['p_name'],data: featuredData[index]));
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.network(featuredData[index]['p_imgs'][0],
                                              width:context.screenWidth*0.35,height: context.screenHeight*0.15,fit: BoxFit.cover),
                                          10.heightBox,
                                          '${featuredData[index]['p_name']}'.text.fontFamily(semibold).color(darkFontGrey).make(),
                                          5.heightBox,
                                          '${featuredData[index]['p_price']}'.text.fontFamily(bold).size(15).color(redColor).make(),
                                        ],
                                      ).box.roundedSM.white.margin(const EdgeInsets.all(4)).padding(const EdgeInsets.all(8)).make(),
                                    ))
                                );
                              }
                            },

                          ),
                        ),
                      ],
                    ),
                  ),
                  20.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: SecondSLidersList.length, itemBuilder: (context,index){
                    return Container(
                        child: Image.asset(SecondSLidersList[index],fit: BoxFit.fill,
                        ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make()
                    );
                  }),
                  20.heightBox,
                  Align(
                      alignment: Alignment.topLeft,
                      child: Allprod.text.size(14).fontFamily(bold).make()),
                  10.heightBox,
                  StreamBuilder(
                      stream: FirestoreServices.allProducts(),
                      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                        if(!snapshot.hasData){
                          return  const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),);
                        }else{
                          var allProducts=snapshot.data!.docs;
                          return  GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allProducts.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                                  crossAxisSpacing: 8,mainAxisSpacing: 8,mainAxisExtent: 300),
                              itemBuilder: (context,index){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                        allProducts[index]['p_imgs'][0]
                                        ,width: 200,height:200,fit: BoxFit.fill),
                                    const Spacer(),
                                    10.heightBox,
                                    "${allProducts[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                    5.heightBox,
                                    "${allProducts[index]['p_price']}".text.fontFamily(bold).size(15).color(redColor).make(),
                                  ],
                                ).box.roundedSM.white.margin(const EdgeInsets.all(4)).padding(const EdgeInsets.all(10)).make().onTap(() {
                                  Get.to(()=>ItemDetails(title: "${allProducts[index]['p_name']}"
                                    ,data: allProducts[index]));
                                });
                              });
                        }
                      }),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
