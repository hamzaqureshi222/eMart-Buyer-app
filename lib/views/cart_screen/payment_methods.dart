import 'package:emart/consts/lists.dart';
import 'package:emart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:emart/consts/consts.dart';
import 'package:get/get.dart';
import '../../widgets/login_button.dart';
import '../home_screen/home.dart';
class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(CartController());
    return  Obx(()=> Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
          title: 'Shipping Info'.text.semiBold.color(darkFontGrey).make(),

        ),
        bottomNavigationBar: SizedBox(
          height: context.screenHeight*0.070,
          child: controller.placingOrder.value?const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),)
              :LoginButton(
              onPress: ()async{
                await controller.placeMyOrder(orderPaymentMethod: paymentMethods[controller.pamentIndex.value],
                totalAmount: controller.totalP.value);
                await controller.clearcart();
                VxToast.show(context, msg: 'Order Placed Successfully');
                Get.offAll(const Home());
              },
              color: redColor,
              textColor: whiteColor,
              title: 'Place My Order'
          ),
        ),
        body:  Padding(
            padding: const EdgeInsets.all(12),
            child: Obx(()=> Column(
                children: List.generate(3, (index){
                  return GestureDetector(
                    onTap: (){
                      controller.changePaymentMethod(index);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        border: Border.all(width: 3,
                            color: controller.pamentIndex.value==index?redColor:Colors.transparent,style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children:[ Image.asset(paymentMethodsList[index],width: double.infinity,
                        height: context.screenHeight*0.2,fit: BoxFit.cover,
                        colorBlendMode: controller.pamentIndex.value==index?BlendMode.darken:BlendMode.color,
                          color: controller.pamentIndex==index?Colors.black.withOpacity(0.4):Colors.transparent,
                        ),
                        controller.pamentIndex.value==index?Transform.scale(
                          scale: 1.1,
                          child: Checkbox(value: true,activeColor:Colors.green,shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                          ), onChanged: (value){}),
                        ):Container()
                        ]
                      ),
                    ),
                  );
                })
              ),
            )),
      ),
    );
  }
}
