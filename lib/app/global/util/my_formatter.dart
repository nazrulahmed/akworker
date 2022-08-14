class MyFormatter {
  static String convertTo12hrFormat(int hr, int min) {
    late String hours;
    String minutes = min < 10 ? "0$min" : min.toString();
    late String postFix;

    if (hr == 0) {
      hours = '12';
      postFix = 'AM';
    } else if (hr >= 1 && hr <= 11) {
      hours = hr < 10 ? '0$hr' : hr.toString();
      postFix = 'AM';
    } else if (hr == 12) {
      hours = '12';
      postFix = 'PM';
    } else if (hr >= 13 && hr <= 23) {
      int hoursIn12 = hr - 12;
      hours = hoursIn12 < 10 ? '0$hoursIn12' : hoursIn12.toString();
      postFix = 'PM';
    }

    return "$hours:$minutes $postFix";
  }
}
