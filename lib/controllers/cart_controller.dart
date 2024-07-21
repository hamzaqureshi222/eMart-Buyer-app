import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
class CartController extends GetxController{
  var adresscontroller=TextEditingController();
  var citycontroller=TextEditingController();
  var statecontroller=TextEditingController();
  var postalcodecontroller=TextEditingController();
  var phonecontroller=TextEditingController();

  var totalP=0.obs;
  var pamentIndex=0.obs;
  var placingOrder=false.obs;
  late dynamic productSnapshot;
  var products=[];

  calculate(data){
    totalP.value=0;
    for(var i=0;i<data.length;i++){
      totalP.value=totalP.value+int.parse(data[i]['tprice'].toString());
    }
  }
  changePaymentMethod(index){
    pamentIndex.value=index;
  }
  placeMyOrder({orderPaymentMethod,totalAmount})async{
    placingOrder(true);
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_by':currentUser!.uid,
      'order_by_name':Get.find<HomeController>().username,
      'order_by_email':currentUser!.email,
      'order_by_address':adresscontroller.text,
      'order_by_state':statecontroller.text,
      'order_by_city':citycontroller.text,
      'order_by_phone':phonecontroller.text,
      'order_by_postal':postalcodecontroller.text,
      'shipping_method':'Home Delivery',
      'payment_method':orderPaymentMethod,
      'order_code':DateTime.now().millisecondsSinceEpoch,
      'order_placed':true,
      'order_confirmed':false,
      'order_delivered':false,
      'order_on_delivery':false,
      'order_date':DateTime.now(),
      'total_amount':totalAmount,
      'orders':FieldValue.arrayUnion(products),
      'Vendors': productSnapshot.map((item) => item['sellerId'].toString()).toList()
    });
    placingOrder(false);
  }
  getProductDetails(){
    products.clear();
    for(var i=0;i<productSnapshot.length;i++){
      products.add({
        'color':productSnapshot[i]['color'],
        'img':productSnapshot[i]['img'],
        'qty':productSnapshot[i]['qty'],
        'title':productSnapshot[i]['title'],
        'p_price':productSnapshot[i]['tprice'],
      });
    }
  }
  clearcart(){
    for(var i=0;i<productSnapshot.length;i++){
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}