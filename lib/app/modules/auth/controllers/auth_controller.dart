import 'dart:convert';

import 'package:amar_karigor/app/global/config/constant.dart';
import 'package:amar_karigor/app/global/data/model/user.dart' as AppUser;
import 'package:amar_karigor/app/global/util/app_pref.dart';
import 'package:amar_karigor/app/global/util/local_data.dart';
import 'package:amar_karigor/app/modules/auth/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

enum AuthPages { LOGIN, REGISTER, OTP, PASSWORD, FORGOT_PASSWORD }
enum AuthCode { TRUE, FALSE, ERROR }

class AuthController extends GetxController {
  var verificationId;
  late ConfirmationResult confirmationResult;
  var paddingBottomOnKeyboardOverlap = 0.0.obs;
  var activePage = AuthPages.LOGIN.obs;
  var lastPage = AuthPages.REGISTER.obs;
  var isWaitingForOTP = false.obs;
  var isWaitingForVerification = false.obs;
  var isLoading = false.obs;
  var isValidPhoneNumber = false.obs;
  var isInvalidOTP = false.obs;
  var enableVerifyButton = false.obs;
  var settingPassword = false.obs;
  var obscurePassword = true.obs;
  var obscureRepeatPassword = true.obs;
  String otpMode = "register";

  TextEditingController phoneInputFieldController = TextEditingController();
  TextEditingController otpInputFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController repeatPasswordFieldController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Future<AppPref?> myPref = AppPref.instance;
  final AuthProvider _authProvider = AuthProvider();

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

  void switchPage(AuthPages page) {
    this.activePage.value = page;
    if (page != AuthPages.LOGIN) lastPage.value = activePage.value;
  }

  void toggleOTPIndicator() {
    isWaitingForOTP.value = !isWaitingForOTP.value;
  }

  void toggleVerificationIndicator() {
    isWaitingForVerification.value = !isWaitingForVerification.value;
  }

  void toggleSettingPasswordIndeicator() {
    settingPassword.value = !settingPassword.value;
  }

  Future<AuthCode> isUserExist(String phoneNumber) async {
    String phoneNo = phoneNumber.replaceFirst("+880", "");
    if (phoneNo[0] == '0') phoneNo = phoneNo.split("0")[1].toString();
    String phone = "+880" + phoneNo;
    http.Response response = await _authProvider.isUserExist(phone);

    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == true) {
        return AuthCode.TRUE;
      } else {
        return AuthCode.FALSE;
      }
    }
    return AuthCode.ERROR;
  }

  void phoneSignIn(String phoneNumber) async {
    kIsWeb ? signInWithWeb(phoneNumber) : signInWithApp(phoneNumber);
  }

  void signInWithWeb(String phoneNumber) async {
    try {
      confirmationResult = await auth.signInWithPhoneNumber(
          phoneNumber,
          RecaptchaVerifier(onSuccess: () {
            print('captcha success');
            toggleOTPIndicator();
            switchPage(AuthPages.OTP);
          }, onExpired: () {
            print('captcha onExpired');
          }, onError: (e) {
            toggleOTPIndicator();
            switchPage(AuthPages.REGISTER);
            print('captcha error with ${e.stackTrace}');
          }));
    } on FirebaseAuthException catch (e) {
      switchPage(AuthPages.REGISTER);
      Get.showSnackbar(GetBar(
          isDismissible: true,
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          message: e.message));
      e.printError();
    }
  }

  void verifyOTP(String smsCode) {
    kIsWeb ? verifyOTPWeb(smsCode) : verifyOTPApp(smsCode);
  }

  void verifyOTPApp(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    try {
      await auth.signInWithCredential(credential);
      toggleVerificationIndicator();
      switchPage(AuthPages.PASSWORD);
    } catch (e) {
      isInvalidOTP.value = true;
      otpInputFieldController.text = '';
      toggleVerificationIndicator();
    }
  }

  void verifyOTPWeb(String smsCode) async {
    try {
      await confirmationResult.confirm(smsCode);
      switchPage(AuthPages.PASSWORD);
    } catch (e, st) {
      print(st);
      toggleVerificationIndicator();
      otpInputFieldController.text = '';
      isInvalidOTP.value = true;
      enableVerifyButton.value = false;
    }
  }

  void signInWithApp(String phoneNumber) {
    print('sign in with app');
    auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    if (authCredential.smsCode != null) {
      otpInputFieldController.text = authCredential.smsCode!;
      switchPage(AuthPages.PASSWORD);
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      // showMessage("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    print(forceResendingToken);
    print("code sent");
    toggleOTPIndicator();
    switchPage(AuthPages.OTP);
  }

  _onCodeTimeout(String timeout) {
    return null;
  }

  Future<String> createUser() async {
    String msg = FAILED_MSG;
    String pass = passwordFieldController.text;
    String repeatPass = repeatPasswordFieldController.text;

    if (pass.isEmpty) {
      msg = 'Password can\'t be empty!';
    } else if (pass.length < 6) {
      msg = 'Password should contain at least 6 character!';
    } else if (repeatPass.isEmpty) {
      msg = 'Repeat password can\'t be empty!';
    } else if (pass != repeatPass) {
      msg = 'Password doesn\'t match';
    } else {
      String phoneNo = phoneInputFieldController.text.replaceFirst("+880", "");
      if (phoneNo[0] == '0') phoneNo = phoneNo.split("0")[1].toString();
      String phone = "+880" + phoneNo;
      Map<String, dynamic> user = {'phone': phone, 'password': pass};

      print("USER'S MAP ");
      print(user);
      print("USER'S MAP ");

      http.Response response = await AuthProvider().createExpert(user);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print('data of response ');
        print(data);

        if (data['status'] == true && data['token'] != null) {
          AppPref? appPref = await myPref;
          appPref!.saveToken(data['token']);
          appPref.saveUserId(data['uid'].toString());
          LocalData.user = AppUser.User(data['uid'].toString(), data['token']);
          msg = SUCCESS_MSG;
        } else {
          msg = data['response'];
        }
      }
    }
    return msg;
  }

  Future<String> login() async {
    String msg = FAILED_MSG;
    String phone = phoneInputFieldController.text;
    String pass = passwordFieldController.text;

    if (phone.isEmpty) {
      msg = 'Phone can\'t be empty!';
    } else if (pass.isEmpty) {
      msg = 'Password can\'t be empty!';
    } else {
      String phoneNo = phoneInputFieldController.text.replaceFirst("+880", "");
      if (phoneNo[0] == '0') phoneNo = phoneNo.split("0")[1].toString();
      String phone = "+880" + phoneNo;
      Map<String, dynamic> user = {'phone': phone, 'password': pass};

      http.Response response = await AuthProvider().login(user);
 print("data ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("data $data");
        if (data['status'] == true && data['token'] != null) {
          AppPref? appPref = await myPref;
          appPref!.saveToken(data['token']);
          appPref.saveUserId(data['uid']);
          LocalData.user = AppUser.User(data['uid'], data['token']);
          msg = SUCCESS_MSG;
        } else {
          msg = data['response'];
        }
      }
    }
    return msg;
  }

  Future<String> updatePassword() async {
    String msg = FAILED_MSG;
    String pass = passwordFieldController.text;
    String repeatPass = repeatPasswordFieldController.text;

    if (pass.isEmpty) {
      msg = 'Password can\'t be empty!';
    } else if (pass.length < 6) {
      msg = 'Password should contain at least 6 character!';
    } else if (repeatPass.isEmpty) {
      msg = 'Repeat password can\'t be empty!';
    } else if (pass != repeatPass) {
      msg = 'Password doesn\'t match';
    } else {
      String phoneNo = phoneInputFieldController.text.replaceFirst("+880", "");
      if (phoneNo[0] == '0') phoneNo = phoneNo.split("0")[1].toString();
      String phone = "+880" + phoneNo;
      Map<String, dynamic> user = {'phone': phone, 'password': pass};

      http.Response response = await AuthProvider().updatePassword(user);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        if (data['status'] == true && data['token'] != null) {
          AppPref? appPref = await myPref;
          appPref!.saveToken(data['token']);
          msg = SUCCESS_MSG;
        } else {
          msg = data['response'];
        }
      }
    }
    return msg;
  }
}
