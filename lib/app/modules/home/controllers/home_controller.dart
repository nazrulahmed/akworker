import 'dart:convert';

import 'package:amar_karigor/app/global/data/model/service.dart';
import 'package:amar_karigor/app/global/data/providers/book_service_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:amar_karigor/app/global/util/app_pref.dart';
import 'package:amar_karigor/app/global/data/model/category.dart';
import 'package:amar_karigor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../../global/util/local_data.dart';
///ak worker
class HomeController extends GetxController {
  Future<AppPref?> myPref = AppPref.instance;
  DatabaseReference bookingRef = FirebaseDatabase.instance.ref('booking');
  String mRegisteredCategory = 'cid-2';
  int selectedCategoryId = 0;
  var currentIndex = 0.obs;
  var isLoggingOut = false.obs;
  bool requestReceived = false;
  var totalTask = 0.obs;
  var totalIncome = 0.obs;

  var availableStatus = 0.obs;
  RxBool isChangingAvailableStatus = false.obs;

  changePage(int index) {
    currentIndex.value = index;
  }

  BookServiceProvider bookServiceProvider = BookServiceProvider();

  @override
  void onInit() async {
    super.onInit();
    await getSummary();
    AppPref? appPref = await myPref;
    String booking = appPref!.retriveRunningBooking();
    print('booking::: $booking');
    if (booking != '-1') {
      print('booking::: $booking');
      requestReceived = true;
      final bookingInfo = json.decode(booking);
      String bookingId = bookingInfo['id'];
      String key = bookingInfo['key'];
      String category = bookingInfo['category'];

      String status = await getBookingStatus(bookingId);

      if (status == 'running') {
        Get.offAllNamed(Routes.BOOKING_DETAILS, arguments: {
          "booking_id": bookingId,
          "category": category,
          "key": key,
          "show_customer_info": true
        });
      } else {
        appPref.saveRunningBooking("-1");
      }
    }
  }

  @override
  void onReady() async {
    super.onReady();
    bookingRef.onValue.listen((event) {
      Map<dynamic, dynamic> values = event.snapshot.value as Map;
      if (requestReceived == false) {
        values.forEach((registerdCategory, value) {
          if (mRegisteredCategory == 'all') {
            responseToTheRequest(value, registerdCategory);
          } else if (registerdCategory == mRegisteredCategory) {
            responseToTheRequest(value, registerdCategory);
          }
        });
      }
    });
  }

  void responseToTheRequest(
      Map<dynamic, dynamic> value, registerdCategory) async {
    String key = value.keys.toList().first;
    String bid = value[key]['bid'];
    int currentStatus = value[key]['current_status'];
    if (currentStatus == 1) {
      if (await isRequestCancelledByExpert(bid)) {
        return;
      }

      await Future.delayed(Duration(seconds: 3));
      requestReceived = true;
      Get.toNamed(Routes.BOOKING_DETAILS, arguments: {
        "booking_id": bid,
        "category": registerdCategory,
        "key": key
      });
    }
  }

  Future<String> getBookingStatus(String bookingId) async {
    http.Response response =
        await bookServiceProvider.getBookingDetails(bookingId);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == true) {
        final bookingResponse = data['response'];
        if (bookingResponse['status'] != null) {
          if (bookingResponse['done_by'] == LocalData.user!.uid) {
            if (bookingResponse['pre_complete_status'] != "1") {
              return "expired";
            }
            else if (bookingResponse['status'] != "2") {
              return "expired";
            }
            
          }
        }
      }
    }
    return "running";
  }

  Future<void> getSummary() async {
    http.Response response = await bookServiceProvider.getSummary();
    print("SUMMARY :::::::::::::::::::  \n"+response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == true) {
        final summary = data['response'];
        int status = summary['status'];
        if (status != 1) {
          Get.offAllNamed(Routes.NOTIFICATION);
          return;
        }
        totalTask.value = summary['total_task'];
        totalIncome.value = summary['total_income'];
        availableStatus.value = summary['available_status'];
      }
    }
    return;
  }

  Future<bool> logout() async {
    AppPref? appPref = await myPref;
    isLoggingOut.value = true;
    return await appPref!.logout();
  }

  @override
  void onClose() {}

  Future<void> changeAvailableStatus(int status) async {
    isChangingAvailableStatus(true);
    http.Response response =
        await bookServiceProvider.changeAvailableStatus(status);
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == true && data['response'] == true) {
        availableStatus.value = status;
      }
    }
    isChangingAvailableStatus(false);

    return;
  }

  Future<bool> isRequestCancelledByExpert(String bid) async {
    http.Response response =
        await bookServiceProvider.isRequestCancelledByExpert(bid);
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == true &&
          (data['response'] == 2 || data['response'] == 4)) {
        return true;
      }
    }
    return false;
  }
}
