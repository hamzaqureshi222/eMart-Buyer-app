import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/product_controller.dart';
import 'package:emart/views/category_screen/item_details.dart';
import 'package:emart/widgets/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/firestore_services.dart';
class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({super.key,required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategory(widget.title);
  }
  switchCategory(title){
    if(controller.subcat.contains(title)){
      productMethod=FirestoreServices.getSubCategory(title);
    }else{
      productMethod=FirestoreServices.getProducts(title);
    }
  }
  var controller=Get.find<ProductsController>();
  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
      appBar: AppBar(
        title: widget.title!.text.white.fontFamily(semibold).make()
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                  children: List.generate(controller.subcat.length,
                          (index) =>controller.subcat[index].toString().text.fontFamily(semibold).size(12).
                      color(darkFontGrey).makeCentered().box.size(120, 50).rounded.
                      margin(const EdgeInsets.symmetric(horizontal: 4)).white.make().onTap(() {
                        switchCategory(controller.subcat[index].toString());
                        setState(() {
                        });
                          }))
              ),
            ),
            20.heightBox,
            StreamBuilder(
                stream: productMethod,
                builder: (BuildContext context,AsyncSnapshot snapshot){
                  if(!snapshot.hasData){
                    return  const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),),
                      ),
                    );
                  }else if(snapshot.data!.docs.isEmpty){
                    return Expanded(
                      child: "No Products Found!".text.color(darkFontGrey).makeCentered(),
                    );
                  }else{
                    var data=snapshot.data!.docs;
                    return Expanded(
                          child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,mainAxisExtent: 250),
                              itemBuilder: (context,index){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                        data[index]["p_imgs"][0],width: 200,height:context.screenHeight*0.2,fit: BoxFit.fill),
                                    "${data[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                    2.heightBox,
                                    "${data[index]['p_price']}".numCurrency.text.fontFamily(bold).size(15).color(redColor).make(),
                                  ],
                                ).box.roundedSM.white.margin(const EdgeInsets.all(4)).padding(const EdgeInsets.all(10)).make().
                                onTap(() {
                                  controller.checkIfFave(data[index]);
                                  Get.to( ItemDetails(title: "${data[index]['p_name']}",data: data[index],)); });
                              }),
                        );
                  }
                }),
          ],
        )
      )
    );
  }
}
