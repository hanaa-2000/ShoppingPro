import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/product_controller.dart';
import '../../../services/firestore_services.dart';
import '../../category/item_details.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title.text.color(darkFontGrey).make(),
        backgroundColor: whiteColor,
        elevation: 1,
      ),
      body: FutureBuilder(
          future: FirestoreServices.searchProducts(title),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor)),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No products founds !"
                  .text
                  .fontFamily(semibold)
                  .color(darkFontGrey)
                  .makeCentered();
            } else {
              var data = snapshot.data!.docs;

              var filteredData = data
                  .where((element) => element['p-name']
                      .toString()
                      .toLowerCase()
                      .contains(title.toLowerCase()))
                  .toList();


              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 300,
                    ),
                    children: filteredData
                        .mapIndexed((currentValue, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  filteredData[index]["p-imgs"][0],
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                "${filteredData[index]["p-name"]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "${filteredData[index]["p-price"]}"
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
                                .roundedSM
                                .outerShadowMd
                                .margin(const EdgeInsets.symmetric(horizontal: 4))
                                .padding(const EdgeInsets.all(12))
                                .make()
                                .onTap(() {
                              controller.checkIfFav(filteredData[index]);
                              Get.to(() => ItemDetails(
                                    title: filteredData[index]["p-name"],
                                    data: filteredData[index],
                                  ));
                            }))
                        .toList(),
                  ),
                ),
              );
            }
          }),
    );
  }
}
