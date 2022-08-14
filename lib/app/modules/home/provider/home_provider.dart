import 'package:amar_karigor/app/global/config/api.dart';
import 'package:http/http.dart' as http;
/*
    @author: Nazrul Chowdhury
    @date: 06 December 2021

    |----------------------------------------------------------|
    | Using http library for API calling instead of GetConnect |
    |----------------------------------------------------------|
    
    * GetConnect (get,post) methods are not working properly in Flutter Web.
    * Getting response as null instead of actual response. 
    * Same codebase work well on the Android device.

 */

class HomeProvider {
  Future<http.Response> homePageData(String uid, String token) async {
    String url = '${Api.base_url}${Api.home_data_url}';
    print("URL IS $url token is $token phone is $uid");
    http.Response response = await http.post(Uri.parse(url),
         headers: {"Authorization": token},
        body: {"uid": uid});
    print(response.statusCode);
    print(response.body);
    return response;
  }


}
