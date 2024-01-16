import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/lists.dart';
import '../../controllers/product_controller.dart';
import '../../widgets/custom_button.dart';
import '../chat/chat_screen.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({Key? key, this.title, this.data}) : super(key: key);
  final String? title;
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async{
        controller.resetValue();
        return true;
      },
      child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                controller.resetValue();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            backgroundColor: whiteColor,
            elevation: .2,
            title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                ),
              ),
              Obx(
                  ()=> IconButton(
                  onPressed: () {
                    if(controller.isFav.value){
                    controller.removeToWishList(data.id , context);
                    //controller.isFav(false);
                    }else{
                      controller.addToWishList(data.id,context);
                    }
                  },
                  icon:  Icon(
                    Icons.favorite,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VxSwiper.builder(
                              itemCount: data["p-imgs"].length,
                              autoPlay: true,
                              height: 350,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1.0,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  data["p-imgs"][index],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                );
                              }),

                          // text
                          10.heightBox,
                          title!.text
                              .size(16)
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          10.heightBox,

                          VxRating(
                            isSelectable: false,
                            value: double.parse(data["p-rating"]),
                            onRatingUpdate: (value) {},
                            normalColor: textfieldGrey,
                            selectionColor: golden,
                            count: 5,
                            maxRating: 5,
                            size: 25,
                          ),
                          10.heightBox,

                          "\$${data["p-price"]}"
                              .text
                              .color(redColor)
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    "Sellers"
                                        .text
                                        .white
                                        .fontFamily(semibold)
                                        .make(),
                                    5.heightBox,
                                    "${data["p-seller"]}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .size(16)
                                        .make(),
                                  ],
                                ),
                              ),
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.message_rounded,
                                  color: darkFontGrey,
                                ),
                              ).onTap(() {
                                Get.to(()=>const ChatScreen(),arguments: [
                                  data["p-seller"],
                                  data["vendor-id"]
                                ]);
                              })
                            ],
                          )
                              .box
                              .height(68)
                              .padding(const EdgeInsets.symmetric(horizontal: 16))
                              .color(textfieldGrey)
                              .make(),
                          //color section
                          20.heightBox,
                          Obx(
                            ()=> Column(
                              children: [
                                //color
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: "Color: "
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ),
                                    Row(
                                      children: List.generate(
                                        data["p-colors"].length,
                                        (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .size(40, 40)
                                                .roundedFull
                                                .color(
                                                    Color(data['p-colors'][index])
                                                        .withOpacity(1.0))
                                                .margin(const EdgeInsets.symmetric(
                                                    horizontal: 4))
                                                .make().onTap(() {
                                              controller.changeColorIndex(index);
                                            }),
                                            Visibility(
                                                visible: index == controller.colorIndex.value,
                                                child: const Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ).box.padding(const EdgeInsets.all(8)).make(),
                                //quantity
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: "Quantity: "
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ),
                                    Obx(
                                      () => Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                controller.decreaseQuantity();
                                                controller.calculateTotalPrice(int.parse(data["p-price"]));
                                              },
                                              icon: const Icon(Icons.remove)),
                                          controller.quantity.value.text
                                              .size(16)
                                              .color(darkFontGrey)
                                              .fontFamily(bold)
                                              .make(),
                                          IconButton(
                                            onPressed: () {
                                              controller.increaseQuantity(
                                                int.parse(data["p-quantity"])
                                              );
                                              controller.calculateTotalPrice(int.parse(data["p-price"]));
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                          10.widthBox,
                                          "(${data["p-quantity"]} available)"
                                              .text
                                              .color(textfieldGrey)
                                              .make(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ).box.padding(const EdgeInsets.all(8)).make(),
                                //total
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: "Total: "
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ),
                                    "\$ ${controller.totalPrice.value}"
                                        .text
                                        .color(redColor)
                                        .size(16)
                                        .fontFamily(bold)
                                        .make(),
                                  ],
                                ).box.padding(const EdgeInsets.all(8)).make(),
                              ],
                            ).box.white.shadowSm.make(),
                          ),
                          // description section
                          10.heightBox,
                          "Description"
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          10.heightBox,
                          "${data["p-desc"]}".text.color(darkFontGrey).make(),
                          // button section
                          10.heightBox,
                          ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: List.generate(
                              itemDetailsButton.length,
                              (index) => ListTile(
                                title: itemDetailsButton[index]
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                trailing: const Icon(Icons.arrow_forward),
                              ),
                            ),
                          ),
                          20.heightBox,
                          //product
                          productyoumayLike.text
                              .fontFamily(bold)
                              .size(16)
                              .color(darkFontGrey)
                              .make(),
                          10.heightBox,
                          //// i copied  from home screen
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                6,
                                (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP1,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    "LapTop  4GB/64GB"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    r"$600"
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .roundedSM
                                    .margin(
                                        const EdgeInsets.symmetric(horizontal: 4))
                                    .padding(const EdgeInsets.all(8))
                                    .make(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: customButton(
                    color: redColor,
                    title: "Add to Cart",
                    onPress: () {
                     if(controller.quantity.value > 0){
                       controller.addToCart(
                         context: context,
                         color: data["p-colors"][controller.colorIndex.value],
                         title: data["p-name"],
                         vendorId: data["vendor-id"],
                         sellerName: data["p-seller"],
                         qty: controller.quantity.value,
                         img: data["p-imgs"][0],
                         tprice: controller.totalPrice.value,
                       );
                       VxToast.show(context, msg: "Added to cart");
                     }else{
                       VxToast.show(context, msg: "Minimum 1 product is required");
                     }
                    },
                    textColor: whiteColor,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
