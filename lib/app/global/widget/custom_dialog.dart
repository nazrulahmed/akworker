import 'package:amar_karigor/app/global/config/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future customDialog(String title,String msg) {
  return Get.dialog(Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(10),
      child: Stack(
      
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white),
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: SingleChildScrollView(
              child: Text(msg,
                  style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            ),
          ),
          Positioned(
              top:10,
              child: Text(title,style: MyTextStyle.textBlackLargeBold,))
        ],
      )));
}
