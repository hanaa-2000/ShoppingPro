import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/appLogo.dart';
import '../../widgets/background_widget.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../home/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isChecked = false;

  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
var passwordRetypeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return backgroundWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                (context.screenHeight * .1).heightBox,
                appLogoWidget(),
                10.heightBox,
                "Join the $appname".text
                    .fontFamily(bold)
                    .white
                    .size(18)
                    .make(),
                15.heightBox,
                Obx(
                  ()=> Column(
                    children: [
                      customTextField(
                        typeText: TextInputType.name,
                        controller: nameController,
                        title: name,
                        hint: nameHint,
                        isPass: false,
                      ),
                      customTextField(
                        typeText: TextInputType.emailAddress,
                        isPass: false,
                        controller: controller.emailController,
                        title: email,
                        hint: emailHint,
                      ),
                      customTextField(
                        typeText: TextInputType.visiblePassword,
                        isPass: true,
                        controller: controller.passwordController,
                        title: password,
                        hint: passwordHint,
                      ),
                      customTextField(
                        typeText: TextInputType.visiblePassword,
                        isPass: true,
                        controller: passwordRetypeController,
                        title: retypePassword,
                        hint: passwordHint,
                      ),

                      5.heightBox,
                      Row(
                        children: [
                          Checkbox(
                            checkColor: whiteColor,
                            activeColor: redColor,
                            value: isChecked,
                            onChanged: (newVal) {
                              setState(() {
                                isChecked = newVal;
                              });
                            },
                          ),
                          10.widthBox,
                          Expanded(
                            child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "I agree to the ",
                                      style: TextStyle(
                                          fontFamily: regular, color: fontGrey),
                                    ),
                                    TextSpan(
                                      text: termAndCond,
                                      style: TextStyle(
                                          fontFamily: regular, color: redColor),
                                    ),
                                    TextSpan(
                                      text: " &",
                                      style: TextStyle(
                                          fontFamily: regular, color: fontGrey),
                                    ),
                                    TextSpan(
                                      text: privetPolicy,
                                      style: TextStyle(
                                          fontFamily: regular, color: redColor),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      5.heightBox,
                      controller.isLoading.value
                          ? const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          ),)
                          : customButton(
                          title: signUp,
                          color: isChecked == true ? redColor : lightGrey,
                          onPress: () async {
                            if (isChecked != false) {
                              controller.isLoading(true);
                              try {
                                await controller.signUp(context: context,).then((value){
                                      return controller.storeUserData(
                                        name: nameController.text,
                                      );
                                }).then((value){
                                    VxToast.show(context, msg: loggedIn);
                                    Get.offAll(()=>const Home());

                                });
                              }catch(e){
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                                controller.isLoading(false);
                              }
                            }
                          },
                          textColor: whiteColor)
                          .box
                          .width(context.screenWidth - 50)
                          .make(),
                      10.heightBox,
                      // RichText(
                      //     text:const TextSpan(
                      //       children: [
                      // TextSpan(
                      //   text: readyHaveAccount,
                      //   style:  TextStyle(fontFamily: bold , color: fontGrey),
                      // ),
                      // TextSpan(
                      //   text: login,
                      //   style:  TextStyle(fontFamily: bold , color: redColor),
                      // ),
                      //
                      //       ],
                      //     )
                      // ).onTap(() {
                      //   Get.back();
                      // }),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          readyHaveAccount.text.color(fontGrey).make(),
                          login.text.color(redColor).make().onTap(() {
                            Get.back();
                          }),
                        ],
                      )
                    ],
                  )
                      .box
                      .white
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .rounded
                      .make(),
                ),


              ],
            ),
          ),
        ));
  }
}
