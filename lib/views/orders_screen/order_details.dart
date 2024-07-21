import 'package:emart/views/orders_screen/components/order_place_details.dart';
import 'package:emart/views/orders_screen/components/order_status.dart';
import 'package:flutter/material.dart';
import 'package:emart/consts/consts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back,color: darkFontGrey,)),
        title: 'Order Details'.text.semiBold.color(redColor).size(20).make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(color: redColor,icon: Icons.done,title: "Order Placed",showDone: data['order_placed']),
            orderStatus(color: Colors.blue,icon: Icons.thumb_up,title: "Confirmed",showDone: data['order_confirmed']),
            orderStatus(color: Colors.yellow,icon: Icons.car_crash,title: "On Delivery",showDone: data['order_on_delivery']),
            orderStatus(color: Colors.purple,icon: Icons.done_all,title: "Delivered",showDone: data['order_delivered']),
            const Divider(),
            10.heightBox,
            Column(
              children: [
                orderPlaceDetails(d1: data['order_code'],d2: data['shipping_method'],title1: 'Order Code',title2: 'Shipping Method'),
                orderPlaceDetails(d1: intl.DateFormat().add_yMd().format((data['order_date'].toDate()))
                    ,d2: data['payment_method'],title1: 'Order Date',title2: 'Payment Method'),
                orderPlaceDetails(d1: 'Unpaid',d2:'Order Placed',title1: 'Payment Status',title2: 'Delivery Status'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          'Shipping Adress'.text.semiBold.make(),
                          '${data['order_by_name']}'.text.make(),
                          '${data['order_by_email']}'.text.make(),
                          '${data['order_by_address']}'.text.make(),
                          '${data['order_by_city']}'.text.make(),
                          '${data['order_by_state']}'.text.make(),
                          '${data['order_by_postal']}'.text.make(),
                        ],
                      ),
                      SizedBox(
                        width: context.screenWidth*0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'Total Amount'.text.semiBold.make(),
                            '${data['total_amount']}'.text.color(redColor).make()
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ).box.outerShadowMd.white.make(),
            10.heightBox,
            'Ordered Product'.text.size(16).color(darkFontGrey).semiBold.makeCentered(),
            10.heightBox,
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(data['orders'].length, (index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderPlaceDetails(
                      title1:data['orders'][index]['title'],
                        title2:data['orders'][index]['p_price'],
                      d1: '${data['orders'][index]['qty']}x',
                      d2: 'Refundable'
                    ),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: 30,
                      height: 20,
                      color: Color(data['orders'][index]['color']),
                    ),)
                  ],
                );
              }).toList()
            ).box.outerShadowMd.white.padding(const EdgeInsets.only(bottom: 5)).make(),
            20.heightBox,
          ],
        ),
      ),
    );
  }
}
