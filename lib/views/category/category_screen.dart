import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/views/category/category_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../widgets/background_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return backgroundWidget(
      child: Scaffold(
        appBar:AppBar(
          leading: const Center(),
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
             itemCount: 9,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200
              ),
              itemBuilder: (context , index){
                return Column(
                  children: [
                    Image.asset(categoryImage[index],height: 120,width: 200,fit: BoxFit.cover,),
                    10.heightBox,
                    categoryList[index].text.color(darkFontGrey).align(TextAlign.center).make(),
                  ],
                ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
                  controller.getSubCategories(categoryList[index]);

                  Get.to(()=>CategoryDetails(title:  categoryList[index],));
                });
              }),
        ),
      ),

    );
  }
}
