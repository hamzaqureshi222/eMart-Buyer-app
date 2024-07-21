import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/cart_controller.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/cart_screen/shipping_screen.dart';
import 'package:emart/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(CartController());
    return  Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),
              );
            }else if(snapshot.data!.docs.isEmpty){
              return Center(
                child: "Cart Is Empty".text.color(darkFontGrey).make()
              );
            }else{
              var data=snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot=data;
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context,int index){
                          return ListTile(
                            leading: Image.network("${data[index]['img']}",width: 80,fit: BoxFit.cover),
                            title: "${data[index]['title']} x${data[index]['qty']}".text.size(16).semiBold.make(),
                            subtitle: '${data[index]['tprice']}'.numCurrency.text.color(redColor).fontFamily(semibold).make(),
                            trailing: IconButton(onPressed: (){
                              FirestoreServices.deleteDocument(data[index].id);
                            }, icon: const Icon(Icons.delete,color: redColor,)),
                          );
                        })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price".text.color(darkFontGrey).fontFamily(semibold).make(),
                        Obx(()=> '${controller.totalP.value}'.text.color(redColor).fontFamily(semibold).make()),
                      ],
                    ).box.padding(const EdgeInsets.all(12)).color(lightgolden).width(context.screenWidth -60).roundedSM.make(),
                    10.heightBox,
                    SizedBox(width: context.screenWidth -60,
                      child: LoginButton(
                          color: redColor,onPress: (){
                            Get.to(const ShippingDetails());
                      },textColor: whiteColor,title: 'Proceed To Pay'),
                    )
                  ],
                ),
              );
          }
          })
    );
  }
}

