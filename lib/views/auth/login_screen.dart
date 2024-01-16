import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/lists.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/appLogo.dart';
import '../../widgets/background_widget.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../home/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.put(AuthController());

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
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                    typeText: TextInputType.emailAddress,
                    title: email,
                    hint: emailHint,
                    controller: controller.emailController,
                    isPass: false,
                  ),
                  customTextField(
                    typeText: TextInputType.visiblePassword,
                    isPass: true,
                    controller: controller.passwordController,
                    title: password,
                    hint: passwordHint,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgetPass.text.make(),
                    ),
                  ),
                  5.heightBox,
                  controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        ))
                      : customButton(
                              title: login,
                              color: redColor,
                              onPress: () async {
                                controller.isLoading(true);
                                await controller
                                    .loginUser(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: loggedIn);
                                    Get.offAll(() => const Home());
                                  }else{
                                    controller.isLoading(false);
                                  }
                                });
                              },
                              textColor: whiteColor)
                          .box
                          .width(context.screenWidth - 50)
                          .make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  customButton(
                      color: lightGolden,
                      title: signUp,
                      textColor: redColor,
                      onPress: () {
                        Get.to(() => const SignUpScreen());
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: lightGrey,
                                child: Image.asset(
                                  socialListIcons[index],
                                  width: 30,
                                ),
                              ),
                            )),
                  ),
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
