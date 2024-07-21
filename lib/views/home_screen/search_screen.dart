import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../category_screen/item_details.dart';
class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
        leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
      ),
      body: FutureBuilder(
          future: FirestoreServices.searchProducts(title),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),);
            }else if(snapshot.data!.docs.isEmpty){
              return 'No products found'.text.makeCentered();
            }else{
               var data=snapshot.data!.docs;
               var filtered=data.where((element) => element['p_name']
                   .toString().toLowerCase().contains(title!.toLowerCase())).toList();
              return GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:2,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 300
              ),
                  children: filtered.mapIndexed((currentValue,index)=>
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                              filtered[index]['p_imgs'][0]
                              ,width: 200,height:200,fit: BoxFit.fill),
                          const Spacer(),
                          10.heightBox,
                          "${filtered[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                          5.heightBox,
                          "${filtered[index]['p_price']}".text.fontFamily(bold).size(15).color(redColor).make(),
                        ],
                      ).box.roundedSM.white.margin(const EdgeInsets.all(4)).padding(const EdgeInsets.all(10)).make().onTap(() {
                        Get.to(()=>ItemDetails(title: "${filtered[index]['p_name']}"
                            ,data: filtered[index]));
                      })
                  ).toList(),);
            }
          })
    );
  }
}
