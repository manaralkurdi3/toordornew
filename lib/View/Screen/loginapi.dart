import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<bool> loginApi(
    String username, String userpassword, String api) async {
  try {
    final response = await http.get(
        Uri.parse(
            'http://beta.qistas.com/v3presearch3ApiV2/apiv2/json/login/auth'),
        headers: {
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      data = data['data'];
      //===== Error Handling :

      if (data.containsKey('error') || !data.containsKey('key')) {
        //_error = data['error'];
        return false;
      }
      //============================
      return true;
    } else {
    //  _error = response.statusCode.toString();
      return false;
    }
  } on SocketException catch (e) {
   print( "تاكد من اتصالك بالشبكة ثم حاول لاحقا");
    return false;
  } catch (e) {
    print( "حدث خطا ما, يرجى المحاولة فيما بعد");
    return false;
  }
}
