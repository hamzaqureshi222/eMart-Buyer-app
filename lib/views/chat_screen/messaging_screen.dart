import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
        title: 'My Messages'.text.semiBold.color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllMessages(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return  const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),);
            }else if(snapshot.data!.docs.isEmpty){
              return 'No Messages yet'.text.color(darkFontGrey).makeCentered();
            }else{
              var data=snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(child:
                  ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context,int index){
                    return Card(
                      child: ListTile(
                        onTap: (){
                          Get.to(const ChatScreen(),arguments: [
                            data[index]['friendname'],data[index]['toId']
                          ]);
                        },
                        leading: const CircleAvatar(
                          backgroundColor: redColor,
                          child: Icon(Icons.person,color: Colors.white,),
                        ),
                        title: '${data[index]['friendname']}'.text.semiBold.color(darkFontGrey).make(),
                        subtitle: '${data[index]['last_msg']}'.text.color(darkFontGrey).make(),
                      ),
                    );
                  }))
                ],
              );
            }
          }),
    );
  }
}
