import 'package:amar_karigor/app/modules/auth/controllers/auth_controller.dart';
import 'package:amar_karigor/app/modules/auth/views/widget/phone_number.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widget/otp.dart';
import 'widget/password.dart';

Scaffold register(AuthController controller) {
  return Scaffold(
      body: SingleChildScrollView(
    child: Container(
      margin: EdgeInsets.all(32),
      child: Obx(() {
        if (controller.activePage == AuthPages.REGISTER)
          return phoneNumber(controller);
        else if (controller.activePage == AuthPages.OTP)
          return OTP(controller);
        else
          return password(controller);
      }),
    ),
  ));
}
