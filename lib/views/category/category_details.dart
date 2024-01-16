import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
import '../../services/firestore_services.dart';
import '../../widgets/background_widget.dart';
import 'item_details.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  var controller = Get.put(ProductController());
  dynamic productMethod;

  @override
  void initState() {
    switchCategory(widget.title);
    super.initState();
  }

  switchCategory(title){
  if(controller.subCat.contains(title)){
    productMethod= FirestoreServices.getSubCategories(widget.title);
  }else{
    productMethod= FirestoreServices.getProducts(widget.title);
  }

  }



  @override
  Widget build(BuildContext context) {


    return backgroundWidget(
      child: Scaffold(
        appBar: AppBar(
          title: widget.title!.text.fontFamily(bold).white.make(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: List.generate(
                    controller.subCat.length,
                        (index) =>"${controller.subCat[index]}"
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .size(12)
                        .makeCentered()
                        .box
                        .white
                        .rounded
                        .size(120, 60)
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .make().onTap(() {
                          switchCategory("${controller.subCat[index]}");
                        setState(() {
                        });
                        }),
                  ),
                ),
              ),
            ),
            20.heightBox,
            StreamBuilder(
              stream:productMethod,
              //FirestoreServices.getProducts(widget.title),
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                if(!snapshot.hasData){
                  return const Expanded(child: Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor)),
                  ),);
                }
                else if(snapshot.data!.docs.isEmpty){
                  return Expanded(child:  "No products found!".text.color(darkFontGrey).makeCentered(),);
                }

              else{

                var data = snapshot.data!.docs;

                  return ///// ITEMS container
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 250,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          data[index]["p-imgs"][0],
                                          height: 150,
                                          width: 200,
                                          fit: BoxFit.cover,
                                        ),
                                        "${data[index]["p-name"]}"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "\$ ${data[index]["p-price"]}.00"
                                            .text
                                            .color(redColor)
                                            .fontFamily(bold)
                                            .size(16)
                                            .make(),
                                        10.heightBox,
                                      ],
                                    )
                                        .box
                                        .white
                                        .outerShadowSm
                                        .roundedSM
                                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                                        .padding(const EdgeInsets.all(12))
                                        .make().onTap(() {

                                      controller.checkIfFav(data[index]);
                                      Get.to(()=>  ItemDetails(title: "${data[index]["p-name"]}",data: data[index],));
                                    });
                                  }),
                            ));


                }

              },

            ),
          ],
        ),
      ),
    );
  }
}
