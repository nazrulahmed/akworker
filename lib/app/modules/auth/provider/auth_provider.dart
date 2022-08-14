import 'package:amar_karigor/app/global/config/api.dart';
import 'package:http/http.dart' as http;
/*
    @author: Nazrul Chowdhury
    @date: 24 April 2022

    |----------------------------------------------------------|
    | Using http library for API calling instead of GetConnect |
    |----------------------------------------------------------|
    
    * GetConnect (get,post) methods are not working properly in Flutter Web.
    * Getting response as null instad of actual response. 
    * Same codebase work well on the Android device.

 */

class AuthProvider {
  Future<http.Response> createExpert(Map<String, dynamic> user) async {
    String url = '${Api.base_url}${Api.register_expert_url}';
    http.Response response = await http.post(Uri.parse(url), body: user);

    return response;
  }

  Future<http.Response> updatePassword(Map<String, dynamic> user) async {
    String url = '${Api.base_url}${Api.update_password}';
    http.Response response = await http.post(Uri.parse(url), body: user);

    return response;
  }

  Future<http.Response> login(Map<String, dynamic> user) async {
    String url = '${Api.base_url}${Api.login_url}';
    print(url);
    print(user);
    try {
      http.Response response = await http.post(Uri.parse(url), body: user);

      return response;
    } catch (e) {
      print(e.toString());
      return http.Response(e.toString(), 502);
    }
  }

  Future<http.Response> isUserExist(String phone) async {
    String url = '${Api.base_url}${Api.check_expert}';
    try {
      http.Response response =
          await http.post(Uri.parse(url), body: {'phone': phone});

      return response;
    } catch (e) {
      print(e.toString());
      return http.Response(e.toString(), 502);
    }
  }
}
