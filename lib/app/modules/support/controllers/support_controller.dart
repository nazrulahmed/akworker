import 'dart:io';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

    Future<void> makePhoneCall(String phoneNumber) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launch(launchUri.toString());
    }
    Future<void> openEmail(String email) async {
     
      await launch('mailto:$email');
    }

  Future<void>  openWhatsapp(String phoneNumber) async{
    
    var whatsappURl_android = "whatsapp://send?phone="+phoneNumber+"&text=hello";
    var whatappURL ="https://wa.me/$phoneNumber?text=${Uri.parse("hello")}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL)){
         await launch(whatappURL, forceSafariVC: false);
      }else{
       
      }
    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        await launch(whatappURL);
        
      }
    }
  }

}
