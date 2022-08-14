import 'package:amar_karigor/app/global/config/api.dart';
import 'package:http/http.dart' as http;
/*
    @author: Nazrul Chowdhury
    @date: 29 January 2022

    |----------------------------------------------------------|
    | Using http library for API calling instead of GetConnect |
    |----------------------------------------------------------|
    
    * GetConnect (get,post) methods are not working properly in Flutter Web.
    * Getting response as null instead of actual response. 
    * Same codebase work well on the Android device.

 */

class ProfileProvider {
  Future<http.Response> updateProfile(Map<String, dynamic> userInfo) async {
    String url = '${Api.base_url}${Api.update_profile_url}';

    print('USER INFO');
    print(userInfo);

    http.Response response = await http.post(Uri.parse(url),
        headers: {"Authorization": userInfo['token']}, body: userInfo);
    print(response.statusCode);
    print(response.body);
    return response;
  }
}
