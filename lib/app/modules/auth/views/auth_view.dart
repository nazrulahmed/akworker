import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'login.dart';
import 'register.dart';
import 'widget/forgot_password.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.activePage == AuthPages.LOGIN
          ? login(controller)
          : controller.activePage == AuthPages.FORGOT_PASSWORD
          ?forgotPassword(controller):register(controller);
    });
  }
}
