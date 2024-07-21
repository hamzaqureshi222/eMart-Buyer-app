import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/orders_screen/order_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
        title: 'My Orders'.text.semiBold.color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllorder(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return  const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),);
            }else if(snapshot.data!.docs.isEmpty){
              return 'No orders yet'.text.color(darkFontGrey).makeCentered();
            }else{
              var data=snapshot.data!.docs;
              return ListView.builder(
                itemCount: data.length,
                  itemBuilder: (BuildContext context ,int index){
                    return ListTile(
                      leading: '${index+1}'.text.make(),
                      title: data[index]['order_code'].toString().text.color(redColor).semiBold.make(),
                      subtitle: data[index]['total_amount'].toString().numCurrency.text.bold.make(),
                      trailing: IconButton(onPressed: (){
                        Get.to(()=> OrdersDetails(data: data[index]));
                      }, icon: const Icon(Icons.arrow_forward_ios_outlined)),

                    );
                  });
            }
          }),
    );
  }
}
