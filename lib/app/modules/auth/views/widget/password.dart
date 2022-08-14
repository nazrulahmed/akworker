import 'package:amar_karigor/app/global/config/app_style.dart';
import 'package:amar_karigor/app/global/config/constant.dart';
import 'package:amar_karigor/app/modules/auth/controllers/auth_controller.dart';
import 'package:amar_karigor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Widget password(AuthController controller) {
  return Center(
    child: Container(
      padding: kIsWeb ? EdgeInsets.all(32) : EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/ak_vertical.png', height: 250),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Setup your password',
                style: MyTextStyle.textBlackLargerBold,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
          SizedBox(
            height: 2,
          ),
          SizedBox(
            height: 8,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextFormField(
                obscureText: controller.obscureRepeatPassword.value,
                controller: controller.repeatPasswordFieldController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.obscureRepeatPassword.value =
                          !controller.obscureRepeatPassword.value;
                    },
                    icon: Icon(controller.obscureRepeatPassword.value
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined),
                  ),
                  border: InputBorder.none,
                  hintText: 'Repeat Password',
                ),
                keyboardType: TextInputType.text,
              )),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: controller.settingPassword.value
                ? Center(
                    child: CircularProgressIndicator(
                    color: MyColors.colorPrimary,
                  ))
                : ElevatedButton(
                    onPressed: () async {
                      controller.settingPassword.value = true;
                      String response = controller.otpMode == 'register'
                          ? await controller.createUser()
                          : await controller.updatePassword();
                      controller.settingPassword.value = false;
                      if (response == SUCCESS_MSG) {
                        Get.offAndToNamed(Routes.HOME);
                      } else {
                        Get.showSnackbar(GetBar(
                            isDismissible: true,
                            duration: Duration(seconds: 2),
                            message: response));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        primary: MyColors.colorPrimary,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                    child: Text('Submit')),
          ),
        ],
      ),
    ),
  );
}
