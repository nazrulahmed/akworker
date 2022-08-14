import 'package:amar_karigor/app/global/util/local_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/support_controller.dart';

class SupportView extends GetView<SupportController> {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Please feel free to reach us',
                style: TextStyle(
                  fontSize: 20,
                )),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/icons/telephone.png'),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      onDoubleTap: () {
                        controller.makePhoneCall(LocalData.providerInfo!.phone!);
                      },
                      child: Text(
                          'Direct call on ${LocalData.providerInfo!.phone!}')),
                ],
              ),
            ),
          ),
       
       Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/icons/whatsapp.png'),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      onDoubleTap: () {
                        controller.openWhatsapp(LocalData.providerInfo!.phone!);
                      },
                      child: Text(
                          'Whatsapp on ${LocalData.providerInfo!.phone!}')),
                ],
              ),
            ),
          ),
       
       Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/icons/email.png'),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      onDoubleTap: () {
                        controller.openEmail(LocalData.providerInfo!.email!);
                      },
                      child: Text(
                          'Email on ${LocalData.providerInfo!.email!}')),
                ],
              ),
            ),
          ),
       
        ],
      ),
    );
  }
}
