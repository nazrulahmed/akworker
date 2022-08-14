import 'dart:convert';

import 'package:amar_karigor/app/global/data/model/booking.dart';
import 'package:amar_karigor/app/global/data/providers/book_service_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../global/config/constant.dart';
import '../../../global/util/app_pref.dart';
import '../../../global/util/local_data.dart';
import '../../../routes/app_pages.dart';

class BookingController extends GetxController {
  final bookServiceProvider = BookServiceProvider();
  DatabaseReference bookingRef = FirebaseDatabase.instance.ref('booking');

  Future<AppPref?> myPref = AppPref.instance;
  Booking? bookingData;
  late String registeredCategory;
  late String key;
  var isAccepting = false.obs;
  var isCancelling = false.obs;
  bool receivedByOtherExpert = false;
  bool showCustomerInfo = false;
  String customerName = '';
  String customerPhone = '';
  String customerEmail = '';
  String customerAddress = '';
  String? bookingId;

  @override
  void onInit() async {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      registeredCategory = args['category'];
      key = args['key'];
      bookingId = args['booking_id'];
      if (args['show_customer_info'] != null) {
        showCustomerInfo = args['show_customer_info'];
      }

      await retriveBookingDetails(bookingId!);
      checkBookingStatus();
    }
  }

  void checkBookingStatus() {
    bookingRef.onValue.listen((event) {
      Map<dynamic, dynamic> values = event.snapshot.value as Map;
      values.forEach((registerdCategory, value) {
        print("value is $value");
        String key = value.keys.toList().first;
        if (value[key]['bid'] != null) {
          String bid = value[key]['bid'];

          if (bid == bookingId) {
            print("bid is==== $bid");
            String? receiverId = value[key]['receiver_id'];
print("receiverId is==== $receiverId");
            if (receiverId != null && receiverId != "-1" && receiverId != LocalData.user!.uid) {
              receivedByOtherExpert = true;
              update();
            }
          }
        }
      });
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> updateBookingResponse(int status) async {
    http.Response response = await bookServiceProvider.updateBookingResponse(
        LocalData.user!.uid, bookingData!.id!, status);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == true && data['response'] == true) {
        if (status == BOOKING_RESPONSE_DONE) {
        
          Get.toNamed(Routes.TASK_COMPLETE);
        }else{
           Get.toNamed(Routes.TASK_CANCEL);
        }
      }
    }
  }

  void cancelBookingRequest() async {
    if (isAccepting.value == true) return;
    isCancelling.value = true;
    http.Response response = await bookServiceProvider.storeResponse(
        LocalData.user!.uid, bookingData!.id!, 2);
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == true && data['response'] == true) {
        isAccepting.value = false;
        Get.back();
      }
    }
  }

  Future<void> acceptBookingRequest() async {
    if (isCancelling.value == true) return;

    isAccepting.value = true;
    await bookingRef
        .child(registeredCategory)
        .child(key)
        .update({'current_status': 2, 'receiver_id': LocalData.user!.uid});

    http.Response response = await bookServiceProvider.storeResponse(
        LocalData.user!.uid, bookingData!.id!, 1);

    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == true && data['response'] == true) {
        isAccepting.value = false;
        retriveConsumerDetails();
        Map<String, dynamic> bookingInfo = {
          "id": bookingData!.id!,
          "category": registeredCategory,
          "key": key
        };
        AppPref? appPref = await myPref;
        appPref!.saveRunningBooking(json.encode(bookingInfo));
      }
    } else {
      isAccepting.value = false;
      Get.showSnackbar(GetBar(
          isDismissible: true,
          duration: Duration(seconds: 2),
          message: "Something went wrong. Please try again!"));
    }
  }

  Future<void> retriveConsumerDetails() async {
    http.Response response = await bookServiceProvider.getCustomerInfo(
        bookingData!.uid!, bookingData!.bookingType!, bookingData!.id!);
    final data = json.decode(response.body);
    print(data);
    if (data['status'] == true) {
      final result = data['response'];
      customerName = result['name'];
      customerPhone = result['phone'];
      customerEmail = result['email'];
      customerAddress = result['address'];

      showCustomerInfo = true;
      update();
    }
    return;
  }

  @override
  void onClose() {}

  Future<void> retriveBookingDetails(String bookingId) async {
    http.Response response =
        await bookServiceProvider.getBookingDetails(bookingId);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == true) {
        final bookingResponse = data['response'];

        final serviceOptions = jsonDecode(bookingResponse['options']);

        bookingData = Booking(
            uid: bookingResponse['uid'],
            id: bookingResponse['id'],
            serviceId: serviceOptions['service_id'],
            serviceName: serviceOptions['service_name'],
            attribute: serviceOptions['selected_attributes'],
            bookingDate: serviceOptions['booking_date'],
            bookingTime: serviceOptions['booking_time'],
            totalToPay: serviceOptions['total_price'],
            icon: serviceOptions['service_icon'],
            bookingType: bookingResponse['booking_type'],
            status: bookingResponse['status']);

        if (showCustomerInfo) {
          retriveConsumerDetails();
        } else {
          update();
        }
      }
    }
  }
}
