import 'package:amar_karigor/app/global/config/app_style.dart';
import 'package:amar_karigor/app/global/config/constant.dart';
import 'package:amar_karigor/app/modules/auth/controllers/auth_controller.dart';
import 'package:amar_karigor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Scaffold login(AuthController controller) {
  return Scaffold(
      body: Center(
    child: Container(
      width: kIsWeb ? 600 : double.infinity,
      height: kIsWeb ? 700 : double.infinity,
      decoration:
          kIsWeb ? BoxDecoration(border: Border.all(color: Color(0xffdddddd))) : null,
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60,),
                Image.asset('assets/images/logo.png',height: 100,),
                SizedBox(height: 10,),
                Text('Ami Karigor',style: TextStyle(
                  fontSize: 32,
                  color: MyColors.colorPrimary,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    controller: controller.phoneInputFieldController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      border: InputBorder.none,
                      hintText: 'Phone',
                    ),
                    keyboardType: TextInputType.phone,
                    onChanged: (num) {
                      controller.isValidPhoneNumber.value =
                          GetUtils.isPhoneNumber(num);
                    },
                  ),
                ),
                SizedBox(height: 8),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      obscureText: controller.obscurePassword.value,
                      controller: controller.passwordFieldController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.obscurePassword.value =
                                !controller.obscurePassword.value;
                          },
                          icon: Icon(controller.obscurePassword.value
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined),
                        ),
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (num) {},
                    )),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          controller.switchPage(AuthPages.FORGOT_PASSWORD);
                        },
                        child: Text('forgot password?')),
                  ],
                ),
                SizedBox(height: 20),
                Obx(() {
                  return Container(
                    width: double.infinity,
                    child: controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                            color: MyColors.colorPrimary,
                          ))
                        : ElevatedButton(
                            onPressed: () async {
                              controller.isLoading.value =
                                  !controller.isLoading.value;
                              String response = await controller.login();
                              if (response == SUCCESS_MSG) {
                                Get.offAndToNamed(Routes.HOME);
                              } else {
                                controller.isLoading.value =
                                    !controller.isLoading.value;
                                Get.showSnackbar(GetBar(
                                    isDismissible: true,
                                    duration: Duration(seconds: 2),
                                    message: response));
                              }
                            },
                            style: MyButtonStyle.submitButton,
                            child: Text('Login')),
                  );
                }),
               
               
              ],
            ),
          ),
        ],
      ),
    ),
  ));
}
