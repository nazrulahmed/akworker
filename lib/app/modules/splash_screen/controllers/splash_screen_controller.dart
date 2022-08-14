import 'package:amar_karigor/app/global/data/model/user.dart';
import 'package:amar_karigor/app/global/util/app_pref.dart';
import 'package:amar_karigor/app/global/util/local_data.dart';
import 'package:amar_karigor/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  Future<AppPref?> myPref = AppPref.instance;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    AppPref? pref = await myPref;
    String? token = pref!.retriveToken();
    String? uid = pref.retriveUserId();
    if (token == null || uid == null) {
      Get.offAndToNamed(Routes.AUTH);
    } else {
      print('inside else');

      LocalData.user = User(uid, token);
      print('user = ${LocalData.user!.uid} and token = ${LocalData.user!.token}');
      Get.offAndToNamed(Routes.HOME);
    }
  }

  @override
  void onClose() {}
}
