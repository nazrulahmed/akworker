import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  final String KEY_TOKEN = "auth_token";
  final String KEY_USER_ID = "uid";
  final String KEY_LOCATION = "location";
  final String KEY_SERVICE = "service";
  final String KEY_BOOKING = "booking";
  final String KEY_USER_INFO = "user_info";
  final String KEY_GROSS_TOTAL = "gross_total";
  final String KEY_BOOKING_ID = "booking_id";
  final String KEY_SERVICE_NAME = "service_name";
  final String KEY_RUNNING_BOOKING = "running_booking";



  static AppPref? _pref;
  static SharedPreferences? _sharedPreferences;

  AppPref._() {}

  static Future<AppPref?> get instance async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
      _pref = AppPref._();
    }

    return _pref;
  }

  void saveToken(token) {
    _sharedPreferences!.setString(KEY_TOKEN, token);
  }

  String? retriveToken() {
    return _sharedPreferences!.getString(KEY_TOKEN) ?? null;
  }

  void saveUserId(String uid) {
    _sharedPreferences!.setString(KEY_USER_ID, uid);
  }

  String? retriveUserId() {
    return _sharedPreferences!.getString(KEY_USER_ID) ?? null;
  }

  void setLocation(String location) {
    _sharedPreferences!.setString(KEY_LOCATION, location);
  }

  String? getLocation() {
    return _sharedPreferences!.getString(KEY_LOCATION) ?? null;
  }

  Future<bool> logout() async {
    return await _sharedPreferences!.clear();
  }

  void saveService(String service) {
    _sharedPreferences!.setString(KEY_SERVICE, service);
  }

  String? retriveService() {
    return _sharedPreferences!.getString(KEY_SERVICE) ?? null;
  }

  void saveBooking(String booking) {
    _sharedPreferences!.setString(KEY_BOOKING, booking);
  }
  String retriveBooking() {
    return _sharedPreferences!.getString(KEY_BOOKING)?? "no data found";
  }
    void saveUserInfo(String userInfo) {
    _sharedPreferences!.setString(KEY_USER_INFO, userInfo);
  }
  String retriveUserInfo() {
    return _sharedPreferences!.getString(KEY_USER_INFO)?? "no data found";
  }

      void saveGrossTotal(double total) {
    _sharedPreferences!.setDouble(KEY_GROSS_TOTAL, total);
  }
  double retriveGrossTotal() {
    return _sharedPreferences!.getDouble(KEY_GROSS_TOTAL)??0;
  }
  
  void saveBookingId(int bookingId) {
    _sharedPreferences!.setInt(KEY_BOOKING_ID, bookingId);
  }
  int retriveBookingId() {
    return _sharedPreferences!.getInt(KEY_BOOKING_ID)??0;
  }
        void saveServiceName(String serviceName) {
    _sharedPreferences!.setString(KEY_SERVICE_NAME ,serviceName);
  }
  String retriveServiceName() {
    return _sharedPreferences!.getString(KEY_SERVICE_NAME)??"home service";
  }
         void saveRunningBooking(String booking) {
    _sharedPreferences!.setString(KEY_RUNNING_BOOKING,booking);
  }
  String retriveRunningBooking() {
    return _sharedPreferences!.getString(KEY_RUNNING_BOOKING)??'-1';
  }
}
