

class MyBookingData  {
  Map<String, dynamic>  service;
  String selectedOptions;
  double totalPrice;
  String bookingDate;
  String bookingTime;

  MyBookingData(this.service, this.selectedOptions, this.totalPrice,
      this.bookingDate, this.bookingTime);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'service_id': service['id'],
      'service_name': service['name'],
      'service_icon': service['icon'],
      'selected_attributes': selectedOptions.toString(),
      'total_price': totalPrice,
      'booking_date': bookingDate,
      'booking_time': bookingTime
    };
  }

   
}
