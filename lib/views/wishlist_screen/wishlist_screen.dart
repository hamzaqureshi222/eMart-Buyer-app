import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
        title: 'My Wishlist'.text.semiBold.color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getWishlist(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return  const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),);
            }else if(snapshot.data!.docs.isEmpty){
              return 'Wishlist is empty'.text.color(darkFontGrey).makeCentered();
            }else{
              var data=snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context,int index){
                        return  ListTile(
                          leading: Image.network("${data[index]['p_imgs'][0]}",width: 80,fit: BoxFit.cover),
                          title: "${data[index]['p_name']} x${data[index]['p_quantity']}".text.size(16).semiBold.make(),
                          subtitle: '${data[index]['p_price']}'.numCurrency.text.color(redColor).fontFamily(semibold).make(),
                          trailing: IconButton(onPressed: (){
                            FirestoreServices.deleteDocument(data[index].id);
                          }, icon: const Icon(Icons.favorite,color: redColor,).onTap(() {
                            FirestoreServices.removewishlist(data[index].id);
                          })),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
