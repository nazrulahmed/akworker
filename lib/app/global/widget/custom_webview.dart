import 'dart:convert';

import 'package:amar_karigor/app/global/data/model/user.dart';
import 'package:amar_karigor/app/global/util/local_data.dart';
import 'package:amar_karigor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatelessWidget {
  final User user = LocalData.user!;
  final amount;
  final bookingId;
  final serviceName;
  CustomWebView(this.bookingId, this.amount, this.serviceName);

  @override
  Widget build(BuildContext context) {
    String payload =
        "{\"token\":\"80535d79-b11a-447e-b9b4-1b941c2a3a6f\",\"booking_id\":$bookingId,\"uid\":${user.uid},\"amount\":$amount,\"cus_name\":\"${user.firstName}\",\"cus_email\":\"${user.email}\",\"cus_phone\":\"${user.phone}\",\"cus_address\":\"${user.address}\",\"service_name\":\"$serviceName\"}";

    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(payload);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl:
                  "https://amarkarigor.com/api/v1/payment/ssl_commerz?payload=" +
                      encoded,
              onPageStarted: (String url) {
                print('onpage start: $url');

                if (url.contains('api/v1/payment/cancel')) {
                  Get.back();
                }
              },
              onPageFinished: (String url) {
                print('onpage finish: $url');
                if (url.contains('api/v1/payment/ssl_payment_success')) {
                  print('Condition matched');
                 
                   Get.toNamed(Routes.PAYMENT_COMPLETE);
                }
              },
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {},
              onProgress: (int progress) {
                print('WebView is loading (progress : $progress%)');
              },
            ),
          ],
        ),
      ),
    );
  }
}
