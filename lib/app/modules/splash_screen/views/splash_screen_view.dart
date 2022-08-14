import 'package:amar_karigor/app/global/config/app_style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Image.asset('assets/images/logo.png', height: 150)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Ami Karigor', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: MyColors.colorPrimary
              ),),
            ),

            SizedBox(height: 50,),
            Center(child: CircularProgressIndicator())
      ],
    ));
  }
}
