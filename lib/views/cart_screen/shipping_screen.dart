import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/cart_controller.dart';
import 'package:emart/views/cart_screen/payment_methods.dart';
import 'package:emart/widgets/custom_text_field.dart';
import 'package:emart/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {

var controller=Get.put(CartController());
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
        title: 'Shipping Info'.text.semiBold.color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: context.screenHeight*0.070,
        child: LoginButton(
          onPress: (){
            if(controller.adresscontroller.text.length>10){
              Get.to(const PaymentMethods());
            }else{VxToast.show(context, msg: 'Please fill form');}
          },
          color: redColor,
          textColor: whiteColor,
          title: 'Continue'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CustomField(hint: 'Adress',isPass: false,title: 'Adress',controller: controller.adresscontroller),
            CustomField(hint: 'City',isPass: false,title: 'City',controller: controller.citycontroller),
            CustomField(hint: 'State',isPass: false,title: 'State',controller: controller.statecontroller),
            CustomField(hint: 'PostalCode',isPass: false,title: 'PostalCode',controller: controller.postalcodecontroller),
            CustomField(hint: 'Phone',isPass: false,title: 'Phone',controller: controller.phonecontroller),

          ],
        ),
      ),
    );
  }
}
