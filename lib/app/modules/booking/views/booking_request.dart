import 'package:amar_karigor/app/global/config/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/config/constant.dart';
import '../../../routes/app_pages.dart';
import '../controllers/booking_controller.dart';
import 'widget/service_attributes.dart';

class BookingDetails extends GetView<BookingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Booking request', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: GetBuilder(
          builder: (BookingController bookingController) => controller
                  .receivedByOtherExpert
              ? Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Spacer(),
                      Center(
                          child: Text(
                        'This booking has been received by other expert.',
                        textAlign: TextAlign.center,
                        style: MyTextStyle.textBlackLargeBold,
                      )),
                      Container(
                          child: Text('Please be prepare for next booking!',
                              textAlign: TextAlign.center,
                              style: MyTextStyle.textBlackLargeBold)),
                      SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.HOME);
                          },
                          child: Text('Home'),
                          style: MyButtonStyle.submitButton),
                      Spacer(),
                      Spacer(),
                    ],
                  ),
                )
              : controller.bookingData != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ListView(
                          children: [
                            Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('REF #${controller.bookingData!.id}',
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 20)),
                                  )),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.bookingData!.serviceName!,
                                  style: MyTextStyle.textBlackLargerBold,
                                ),
                              ],
                            ),
                            Card(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ServiceAttribute(controller.bookingData!.attribute),
                            )),
                            SizedBox(height: 4),
                            Center(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.green[50],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          Text('Booking Date',
                                              style: MyTextStyle
                                                  .textGreenMediumBold),
                                          SizedBox(height: 2),
                                          Row(children: [
                                            Icon(Icons.calendar_today,
                                                color: Colors.green),
                                            SizedBox(width: 5),
                                            Text('${controller.bookingData!.bookingDate}',
                                                style: MyTextStyle
                                                    .textGreenMediumBold)
                                          ]),
                                        ]),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.green[50],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          Text('Booking Time',
                                              style: MyTextStyle
                                                  .textGreenMediumBold),
                                          SizedBox(height: 2),
                                          Row(children: [
                                            Icon(Icons.access_time,
                                                color: Colors.green),
                                            SizedBox(width: 5),
                                            Text('${controller.bookingData!.bookingTime}',
                                                style: MyTextStyle
                                                    .textGreenMediumBold)
                                          ]),
                                        ]),
                                      ),
                                    )
                                  ]),
                            ),
                            SizedBox(height: 12),
                            controller.showCustomerInfo
                                ? SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 150,
                                          child: Obx(
                                            () => controller.isCancelling.value
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: Colors
                                                                .redAccent))
                                                : ElevatedButton(
                                                    onPressed: () => controller
                                                        .cancelBookingRequest(),
                                                    child: Text('Cancel'),
                                                    style: MyButtonStyle
                                                        .dangerButton,
                                                  ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 150,
                                          child: Obx(
                                            () => controller.isAccepting.value
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : ElevatedButton(
                                                    onPressed: () => controller
                                                        .acceptBookingRequest(),
                                                    child: Text('Accept'),
                                                    style: MyButtonStyle
                                                        .submitButton,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            controller.showCustomerInfo
                                ? Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text('Customer Information',
                                              style: MyTextStyle
                                                  .textBlackMediumBold),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text('Name: ',
                                                  style: MyTextStyle
                                                      .textBlackMediumBold),
                                              Text(controller.customerName,
                                                  style: MyTextStyle
                                                      .textBlackMedium),
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            children: [
                                              Text('Phone: ',
                                                  style: MyTextStyle
                                                      .textBlackMediumBold),
                                              Text(controller.customerPhone,
                                                  style: MyTextStyle
                                                      .textBlackMedium),
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            children: [
                                              Text('Address: ',
                                                  style: MyTextStyle
                                                      .textBlackMediumBold),
                                              Text(controller.customerAddress,
                                                  style: MyTextStyle
                                                      .textBlackMedium),
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            children: [
                                              Text('Email: ',
                                                  style: MyTextStyle
                                                      .textBlackMediumBold),
                                              Text(controller.customerEmail,
                                                  style: MyTextStyle
                                                      .textBlackMedium),
                                            ],
                                          ),
                                          SizedBox(height: 24),
                                          Container(
                                            color: Color.fromARGB(
                                                255, 240, 255, 240),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                       controller
                                                          .updateBookingResponse(BOOKING_RESPONSE_CANCEL);
                                                    },
                                                    child: Text('Cancel request',
                                                        style: TextStyle(
                                                            color: Colors.blue)),
                                                  ),
                                                  Spacer(),
                                                  ElevatedButton(
                                                    onPressed: ()async {
                                                      controller
                                                          .updateBookingResponse(BOOKING_RESPONSE_DONE);
                                                    },
                                                    child: Text('Task done'),
                                                    style: MyButtonStyle
                                                        .submitButton,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                    )
                  : Text('Please wait....'),
        ));
  }
}
