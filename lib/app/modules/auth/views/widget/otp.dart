import 'package:amar_karigor/app/global/config/app_style.dart';
import 'package:amar_karigor/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Widget OTP(AuthController controller) {
  return Center(
    child: Container(
      padding:  kIsWeb ? EdgeInsets.all(32):EdgeInsets.all(0),
      width: kIsWeb ? 600 : 600,
      height: kIsWeb ? 700 : 700,
      decoration: kIsWeb
          ? BoxDecoration(border: Border.all(color: Color(0xffdddddd)))
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/ak_vertical.png', height: 250),
          SizedBox(height: 8),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextFormField(
                controller: controller.otpInputFieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.sms),
                  border: InputBorder.none,
                  hintText: 'OTP',
                  
                ),
                onChanged: (num) {
                  controller.enableVerifyButton.value = num.length == 6;

                  controller.isInvalidOTP.value = false;
                },
              )),
          controller.isInvalidOTP.value
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Invalid OTP',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: controller.isWaitingForVerification.value
                ? Center(
                    child: CircularProgressIndicator(
                    color: MyColors.colorPrimary,
                  ))
                : ElevatedButton(
                    onPressed: controller.enableVerifyButton.value
                        ? () {
                            controller.toggleVerificationIndicator();
                            controller
                                .verifyOTP(controller.otpInputFieldController.text);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        primary: MyColors.colorPrimary,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                    child: Text('Next')),
          ),
         
        ],
      ),
    ),
  );
}
