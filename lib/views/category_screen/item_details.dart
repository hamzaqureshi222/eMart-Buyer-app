import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controllers/product_controller.dart';
import 'package:emart/views/chat_screen/chat_screen.dart';
import 'package:emart/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          title: title!.text.color(darkFontGrey).fontFamily(semibold).make(),
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: darkFontGrey),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share, color: darkFontGrey)),
            Obx(() => IconButton(
              onPressed: () {
                if (controller.isFav.value) {
                  controller.removeFromWishlist(data.id);
                } else {
                  controller.addToWishlist(data.id);
                }
              },
              icon: Icon(Icons.favorite_outlined, color: controller.isFav.value ? redColor : darkFontGrey),
            ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VxSwiper.builder(
                            height: context.screenHeight * 0.32,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1.0,
                            itemCount: data['p_imgs'].length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                data['p_imgs'][index],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                          10.heightBox,
                          title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                          10.heightBox,
                          VxRating(
                            value: double.parse(data['p_rating']),
                            onRatingUpdate: (value) {},
                            normalColor: textfieldGrey,
                            selectionColor: golden,
                            size: 25,
                            maxRating: 5,
                          ),
                          10.heightBox,
                          "\$${data['p_price']}".text.color(redColor).size(18).fontFamily(bold).make(),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "Seller".text.white.fontFamily(semibold).make(),
                                    5.heightBox,
                                    "${data['p_seller']}".text.color(darkFontGrey).fontFamily(semibold).make(),
                                  ],
                                ),
                              ),
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.message_rounded, color: darkFontGrey),
                              ).onTap(() {
                                Get.to(
                                    const ChatScreen(),
                                    arguments: [
                                      data['p_seller'], data['vendor_id']
                                    ]
                                );
                              })
                            ],
                          ).box.color(textfieldGrey).padding(const EdgeInsets.symmetric(horizontal: 16)).height(context.screenHeight * 0.070).roundedSM.make(),
                          10.heightBox,
                          Obx(() => Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Color".text.color(textfieldGrey).make(),
                                  ),
                                  Row(
                                      children: List.generate(data['p_colors'].length, (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox().size(40, 40)
                                                .roundedFull
                                                .margin(const EdgeInsets.symmetric(horizontal: 6))
                                                .color(Color(data['p_colors'][index]).withOpacity(1.0))
                                                .make()
                                                .onTap(() {
                                              controller.changeColorIndex(index);
                                            }),
                                            Visibility(
                                                visible: index == controller.colorIndex.value,
                                                child: const Icon(Icons.done, color: Colors.white)
                                            )
                                          ]
                                      ))
                                  )
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Quantity".text.color(textfieldGrey).make(),
                                  ),
                                  Obx(() => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.decreaseQuantity();
                                            controller.calculateTotalPrice(int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.remove)
                                      ),
                                      controller.quantity.value.text.size(16).color(fontGrey).fontFamily(bold).make(),
                                      IconButton(
                                          onPressed: () {
                                            controller.increaseQuantity(int.parse(data['p_quantity']));
                                            controller.calculateTotalPrice(int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.add)
                                      ),
                                      10.widthBox,
                                      "(${data['p_quantity']} available)".text.size(14).color(textfieldGrey).fontFamily(bold).make(),
                                    ],
                                  )),
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Total".text.color(textfieldGrey).make(),
                                  ),
                                  "${controller.totalPrice.value}".numCurrency.text.color(redColor).size(16).fontFamily(bold).make()
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                            ],
                          ).box.white.roundedSM.shadowSm.make()),
                          10.heightBox,
                          "Description".text.color(darkFontGrey).semiBold.make(),
                          10.heightBox,
                          '${data['p_desc']}'.text.color(darkFontGrey).semiBold.make(),
                          10.heightBox,
                          ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: List.generate(itemDetailList.length, (index) => ListTile(
                                title: "${itemDetailList[index]}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                trailing: const Icon(Icons.arrow_forward),
                              ))
                          ),
                          20.heightBox,
                          "Products You May Like".text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: List.generate(6, (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(imgP1, width: context.screenWidth * 0.3, fit: BoxFit.cover),
                                    10.heightBox,
                                    "Laptop".text.fontFamily(semibold).color(darkFontGrey).make(),
                                    5.heightBox,
                                    "\$6000".text.fontFamily(bold).size(15).color(redColor).make(),
                                  ],
                                ).box.roundedSM.white.margin(const EdgeInsets.all(4)).padding(const EdgeInsets.all(8)).make())
                            ),
                          ),
                        ],
                      ),
                    )
                )
            ),
            SizedBox(
              width: double.infinity,
              height: context.screenHeight * 0.080,
              child: LoginButton(
                  color: redColor,
                  onPress: () {
                    if (controller.quantity.value > 0) {
                      controller.addToCart(
                        color: data['p_colors'][controller.colorIndex.value],
                        img: data['p_imgs'][0],
                        qty: controller.quantity.value,
                        sellername: data['p_seller'],
                        sellerId: data['vendor_id'],
                        title: data['p_name'],
                        tprice: controller.totalPrice.value,
                      );
                      VxToast.show(context, msg: 'Added To Cart');
                    } else {
                      VxToast.show(context, msg: 'Select at least one product');
                    }
                  },
                  textColor: whiteColor,
                  title: "Add to Cart"
              ),
            )
          ],
        ),
      ),
    );
  }
}
