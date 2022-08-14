import 'dart:convert';

import 'package:amar_karigor/app/global/config/api.dart';
import 'package:amar_karigor/app/global/data/model/consumer.dart';
import 'package:amar_karigor/app/global/data/model/my_booking_data.dart';
import 'package:amar_karigor/app/global/util/local_data.dart';
import 'package:http/http.dart' as http;
/*
    @author: Nazrul Chowdhury
    @date: 11 February 2022

    |----------------------------------------------------------|
    | Using http library for API calling instead of GetConnect |
    |----------------------------------------------------------|
    
    * GetConnect (get,post) methods are not working properly in Flutter Web.
    * Getting response as null instead of actual response. 
    * Same codebase work well on the Android device.

 */

class BookServiceProvider {
  Future<http.Response> getBookingDetails(String bookingId) async {
    String url = '${Api.base_url}${Api.booking_details_url}';
    http.Response response = await http.post(Uri.parse(url), headers: {
      "Authorization": LocalData.user!.token
    }, body: {
      "booking_id": bookingId,
    });
    return response;
  }

  Future<http.Response> changeAvailableStatus(int status) async {
    String url = '${Api.base_url}${Api.change_available_status}';
    http.Response response = await http.post(Uri.parse(url), headers: {
      "Authorization": LocalData.user!.token
    }, body: {
      "status": status.toString(),
      "expert_id": LocalData.user!.uid,
    });
    return response;
  }

  Future<http.Response> storeResponse(
      String uid, String bookingId, int status) async {
    String url = '${Api.base_url}${Api.booking_response}';
    http.Response response = await http.post(Uri.parse(url), headers: {
      "Authorization": LocalData.user!.token
    }, body: {
      "booking_id": bookingId,
      "expert_id": uid,
      "response": status.toString(),
    });
    return response;
  }

  Future<http.Response> updateBookingResponse(
      String uid, String bookingId, int status) async {
    String url = '${Api.base_url}${Api.update_booking_response}';
    http.Response response = await http.post(Uri.parse(url), headers: {
      "Authorization": LocalData.user!.token
    }, body: {
      "booking_id": bookingId.toString(),
      "expert_id": uid,
      "response": status.toString(),
      "comments": ''
    });
    return response;
  }

  Future<http.Response> createBooking(
      MyBookingData booking, double totalToPay, Consumer? consumer) async {
    String url = '${Api.base_url}${Api.create_booking_url}';

    http.Response response = await http.post(Uri.parse(url), headers: {
      "Authorization": LocalData.user!.token
    }, body: {
      "uid": LocalData.user!.uid,
      "total_to_pay": totalToPay.toString(),
      "booking": jsonEncode(booking),
      "date_time": booking.bookingDate + " " + booking.bookingTime,
      "consumer": consumer == null ? '' : jsonEncode(consumer.toJSON())
    });

    return response;
  }

  Future<http.Response> updateBookingPaymentStatus(
      int bookingId, int paymentMethod) async {
    String url = '${Api.base_url}${Api.update_booking_payment_status_url}';

    http.Response response = await http.post(Uri.parse(url), headers: {
      "Authorization": LocalData.user!.token
    }, body: {
      "uid": LocalData.user!.uid,
      "booking_id": bookingId.toString(),
      "payment_method": paymentMethod.toString()
    });

    return response;
  }

  Future<http.Response> getBookings(int status) async {
    String url = '${Api.base_url}${Api.get_booking_url}';

    http.Response response = await http.post(Uri.parse(url), headers: {
      "Authorization": LocalData.user!.token
    }, body: {
      "uid": LocalData.user!.uid,
      "status": status.toString(),
    });

    return response;
  }

  Future<http.Response> consumerInfo(String id) async {
    String url = '${Api.base_url}${Api.get_consumer_info_url}';
    http.Response response = await http.post(Uri.parse(url), headers: {
      "Authorization": LocalData.user!.token
    }, body: {
      "uid": LocalData.user!.uid,
      "booking_id": id,
    });

    return response;
  }

  Future<http.Response> getPaymentStatus(int id) async {
    String url = '${Api.base_url}${Api.get_payment_status_url}';
    http.Response response = await http.post(Uri.parse(url), headers: {
      "Authorization": LocalData.user!.token
    }, body: {
      "booking_id": id.toString(),
    });
    print(response.statusCode);

    return response;
  }

  Future<http.Response> getCustomerInfo(
      String uid, String bookingType, String bookingId) async {
    String url = '${Api.base_url}${Api.customer_details}';
    http.Response response = await http.post(Uri.parse(url), headers: {
      "Authorization": LocalData.user!.token
    }, body: {
      "booking_id": bookingId,
      "booking_type": bookingType,
      "uid": uid,
    });

    return response;
  }

  Future<http.Response> getSummary() async {
    String url = '${Api.base_url}${Api.expert_summary}';
    print('url :$url');
    http.Response response = await http.post(Uri.parse(url),
        headers: {"Authorization": LocalData.user!.token},
        body: {"expert_id": LocalData.user!.uid});


    return response;
  }

    Future<http.Response> isRequestCancelledByExpert(String bid)async {
      String url = '${Api.base_url}${Api.check_request_status}';
    http.Response response = await http.post(Uri.parse(url),
        headers: {"Authorization": LocalData.user!.token},
        body: {"expert_id": LocalData.user!.uid,"booking_id":bid});

    return response;
    }
}
