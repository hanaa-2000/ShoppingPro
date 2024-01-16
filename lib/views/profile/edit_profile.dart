import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets/background_widget.dart';
import 'package:emart_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';
import '../../widgets/custom_text_field.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key, this.data}) : super(key: key);
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    // controller.nameController.text = data["name"];
    // controller.passwordController.text=data["password"];

    return backgroundWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: Obx(
                () =>
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // if data image url and controller is empty
                      data["imageUrl"] ==" " && controller.profileImgPath.isEmpty
                          ? Image
                          .asset(
                        imgProfile2,
                        width: 100,
                        fit: BoxFit.cover,
                      )
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                          :
                      // if data image url is not empty but controller is empty
                      data["imageUrl"] != "" && controller.profileImgPath.isEmpty ?
                      Image.network(data["imageUrl"],width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                          :
                      // if both is empty
                      Image
                          .file(File(controller.profileImgPath.value), width: 100,
                        fit: BoxFit.cover,
                      )
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),


                      10.heightBox,
                      customButton(
                        color: redColor,
                        title: "Change",
                        textColor: whiteColor,
                        onPress: () {
                          controller.changeImage(context: context);
                        },
                      ),
                      const Divider(),
                      20.heightBox,
                      customTextField(
                          controller: controller.nameController,
                          hint: nameHint,
                          title: name,
                          isPass: false,
                          typeText: TextInputType.name),
                      10.heightBox,
                      customTextField(
                          controller: controller.oldpasswordController,
                          hint: passwordHint,
                          title: oldPassword,
                          isPass: true,
                          typeText: TextInputType.visiblePassword),
                     10.heightBox,
                      customTextField(
                          controller: controller.newPasswordController,
                          hint: passwordHint,
                          title: newPassword,
                          isPass: true,
                          typeText: TextInputType.visiblePassword),

                      20.heightBox,
                      controller.isLoading.value ? const Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor)),) :
                      SizedBox(
                        width: context.screenWidth - 60,
                        child: customButton(
                          color: redColor,
                          title: "Save",
                          textColor: whiteColor,
                          onPress: () async {
                            controller.isLoading(true);

                            //if image not selected
                            if(controller.profileImgPath.value.isNotEmpty){
                              await controller.uploadProfileImage();
                            }else{
                              controller.profileImageLink=data["imageUrl"];
                            }
                            if(data["password"] == controller.oldpasswordController.text){
                              await controller.changeAuthPassword(
                                email: data["email"],
                                password: controller.oldpasswordController.text,
                                newPassword:controller.newPasswordController.text
                              );


                              await controller.uploadProfile(
                                name: controller.nameController.text,
                                password: controller.newPasswordController.text,
                                imageUrl: controller.profileImageLink,
                              );
                              VxToast.show(context, msg: "updated");
                            }else{
                              VxToast.show(context, msg: "Wrong old Password");
                              controller.isLoading(false);
                            }

                          },
                        ),
                      ),
                    ],
                  )
                      .box
                      .white
                      .shadowSm
                      .padding(const EdgeInsets.all(16))
                      .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
                      .rounded
                      .make(),
                ),
          ),
        ));
  }
}
