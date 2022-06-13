import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/Model/fetch_user_from_list.dart';
import 'package:toordor/Model/login_model.dart';
import 'package:toordor/Model/users.dart';
import 'package:toordor/View/Screen/add_project.dart';
import 'package:toordor/View/Screen/home.dart';
import 'package:toordor/View/Screen/my_business.dart';
import 'package:toordor/View/Screen/my_employees.dart';
import 'package:toordor/View/Screen/user_profile.dart';
import 'package:toordor/View/Screen/category_screen.dart';
import 'package:toordor/View/Screen/home_body.dart';

import 'package:toordor/View/Screen/time_workplace.dart';
import 'package:toordor/const/color.dart';
import 'package:http/http.dart' as http;
import 'package:toordor/const/new_url_links.dart';
import 'package:toordor/const/urlLinks.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import '../Model/fetch_all_businesses.dart';
import '../View/Screen/logout_screen.dart';
import '../view/screen/login_screen.dart';

class Controller {
  static Future myBuisness(BuildContext context, {required int? id}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String _token = preferences.getString('token') ?? '';

    Map<String, String> header = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    http.Response response = await http
        .get(Uri.parse(ApiLinks.serviceIndex + '$id'), headers: header);
    if (response.statusCode == 200) {
      Map<String, dynamic> decodeData = json.decode(response.body);
      return decodeData;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Some ting Wrong!!')));
    }
  }

  static List<String> category = [
    "صالون حلاقة ",
    "صالونات تجميل ",
    "تصميم اظافر - עיצוב ציפורניים",
    "تعليم القيادة - מורי נהיגה",
    "غسيل سيارات - שטיפת רכבים",
    "مدرس خاص - מורים פרטיים",
    "صالات رسم الوشم - מכוני קעקועים",
    "مدرب شخصي - מאמן אישי",
    "علاج واستشارة طبية - יעוץ וטיפול רפואי",
    "تصوير - צילום",
    "مدرب حيوانات - מאלפי חיות",
    "مدرب سباحة - מורה שחיה",
    "تدريب الفنون - מאמני אומנות",
    "كراجات وتصليح - מוסכים",
    "مدقق حسابات - רואי חשבון",
    "محامين - עורכי דין",
    "ميادين الرماية - מטווחי ירי",
    "عرافة - מגידת עתידות",
    "علاج طبيعي/ فيزوترابيا - פיזוטרפיה",
    "منتجع صحي وتدليك - מכוני ספא ומסאג'",
    "طباعة الوشم - מכוני קעקועים",
    "مستشار - יועצים",
    "وسيط/وكيل - מתווכים",
    "طبيب بيطري - ויטרינר וטיפולי חיות",
    "مطاحن - מטחנות קמח",
    "مجالس محلية - מועצות מקומיות",
    "معاصر الزيتون - בתי בד",
    "طبيب اسنان - רופא שיניים",
  ];

  static Future userData(BuildContext context) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    String id = await SharedPreferences.getInstance()
        .then((value) => value.getString('id') ?? '');
    String username = await SharedPreferences.getInstance()
        .then((value) => value.getString('username') ?? '');
    print(username);

    Map<String, String> header = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    http.Response response =
        await http.get(Uri.parse(ApiLinks.book + "?uID=$id"), headers: header);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> arrayObjsText = jsonDecode(response.body);
      return arrayObjsText;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('حدث خطأ ما!')));
    }
  }

  Future updateBusiness(BuildContext context,
      {required String phoneNumber,
      required String nameProject,
      required String specilization,
      required String email,
      required String country,
      required String city}) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    Map<String, String> header = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    http.Response response = await http.post(Uri.parse(updateBusinesses),
        headers: header,
        body: json.encode({
          "uID": phoneNumber,
          "bFullName": nameProject,
          "bPhone1": phoneNumber,
          "bEmailAdrs": email,
          "adrsCity": city,
          "bCountry": country,
          "logoPNG": null,
          "bBranch1": specilization,
          "isActive1": true
        }));
    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                content: Text('حدث خطا ما ${response.statusCode}'),
              ));
    }
  }

  Future insertBusiness(BuildContext context,
      {required String phoneNumber,
      required String nameProject,
      required String specialization,
      required String email,
      required setState,
      String? country,
      String? city,
      required TimeOfDay from,
      required TimeOfDay to,
      }) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');

    Map<String, String> header = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    Uri uri=Uri.parse(ApiLinks.busineesCreate);
     uri.replace(queryParameters:  {
       "business_name":nameProject,
       "phone":phoneNumber,
       "email":email,
       "specialization":specialization,
       "weekends":"",
       "from_date":from,
       "to_date":to,
       "country_id":country,
       "city_id":2

     });













    http.Response response = await http.get(uri,
        headers: header);


    if (response.statusCode == 200) {
      print('Business added');
      setState(() => listPage[2]);
    } else {
      showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                content: Text('حدث خطا ما ${response.statusCode}'),
              ));
    }
  }

  Future fetchBusiRequists() async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    http.Response response =
        await http.get(Uri.parse(getAllBusiRequists), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
  }

  Future updateBusiRequists() async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    http.Response response = await http.post(Uri.parse(updateBusinesses),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: json.encode({
          "baseSecurityParam": {"userKey": 0, "orgKey": 0, "roleKey": 0},
          "currentState": 0,
          "sortExpression": "string",
          "totalRecord": 0,
          "pageSize": 0,
          "currentPage": 0,
          "rowNumber": 0,
          "returnKey": 0,
          "bRID": 0,
          "bID": 0,
          "uID": 0,
          "reqUID": 0,
          "msgText": "string",
          "sentAtDate": 0,
          "xMsgText": "string",
          "confrmdAtDate": 0,
          "rejctdAtDate": 0,
          "isActive1": true
        }));
  }

  Future insertBusiRequists() async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    http.Response response = await http.post(Uri.parse(addBusiRequists),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: json.encode({
          "baseSecurityParam": {"userKey": 0, "orgKey": 0, "roleKey": 0},
          "currentState": 0,
          "sortExpression": "string",
          "totalRecord": 0,
          "pageSize": 0,
          "currentPage": 0,
          "rowNumber": 0,
          "returnKey": 0,
          "bRID": 0,
          "bID": 0,
          "uID": 0,
          "reqUID": 0,
          "msgText": "string",
          "sentAtDate": 0,
          "xMsgText": "string",
          "confrmdAtDate": 0,
          "rejctdAtDate": 0,
          "isActive1": true
        }));
  }

  Future getDiaryShift() async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    http.Response response =
        await http.get(Uri.parse(getAllDiaryShifts), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
  }

  Future updateDiaryShift() async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    http.Response response = await http.post(Uri.parse(updateDiaryShifts),
        body: json.encode({
          "baseSecurityParam": {"userKey": 0, "orgKey": 0, "roleKey": 0},
          "currentState": 0,
          "sortExpression": "string",
          "totalRecord": 0,
          "pageSize": 0,
          "currentPage": 0,
          "rowNumber": 0,
          "returnKey": 0,
          "dSID": 0,
          "bID": 0,
          "uID": 0,
          "cUID": 0,
          "workDate": 0,
          "shiftStrt": 0,
          "shiftEnds": 0,
          "uTTID": 0,
          "treatmentType": "string",
          "trtLenght": 0,
          "trtPrice": 0,
          "msg4Users": "string",
          "msg4Supp": "string",
          "dSCompleted": true,
          "isActive1": true
        }),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        });
  }

  Future insertDiaryShifts() async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    http.Response response = await http.post(Uri.parse(addDiaryShifts),
        body: json.encode({
          "baseSecurityParam": {"userKey": 0, "orgKey": 0, "roleKey": 0},
          "currentState": 0,
          "sortExpression": "string",
          "totalRecord": 0,
          "pageSize": 0,
          "currentPage": 0,
          "rowNumber": 0,
          "returnKey": 0,
          "dSID": 0,
          "bID": 0,
          "uID": 0,
          "cUID": 0,
          "workDate": 0,
          "shiftStrt": 0,
          "shiftEnds": 0,
          "uTTID": 0,
          "treatmentType": "string",
          "trtLenght": 0,
          "trtPrice": 0,
          "msg4Users": "string",
          "msg4Supp": "string",
          "dSCompleted": true,
          "isActive1": true
        }),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        });
  }

  Future fetchUsers() async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    http.Response response = await http.get(Uri.parse(getUsers), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
  }

  Future updateUser() async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');

    http.Response response = await http.post(Uri.parse(updateUsers),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: json.encode({
          "baseSecurityParam": {"userKey": 0, "orgKey": 0, "roleKey": 0},
          "currentState": 0,
          "sortExpression": "string",
          "totalRecord": 0,
          "pageSize": 0,
          "currentPage": 0,
          "rowNumber": 0,
          "returnKey": 0,
          "uID": 0,
          "fullName": "string",
          "uName": "string",
          "uPass": "string",
          "phone1": "string",
          "emailAdrs": "string",
          "adrsCity": "string",
          "usrCountry": "string",
          "gMaps": "string",
          "lastLoginDate": 0,
          "logoPNG": "string",
          "resetCode": "string",
          "isSysAdmin": true,
          "isActive1": true
        }));
  }

  Future insertUsers() async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');

    http.Response response = await http.post(Uri.parse(addUsers),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: json.encode({
          "baseSecurityParam": {"userKey": 0, "orgKey": 0, "roleKey": 0},
          "currentState": 0,
          "sortExpression": "string",
          "totalRecord": 0,
          "pageSize": 0,
          "currentPage": 0,
          "rowNumber": 0,
          "returnKey": 0,
          "uID": 0,
          "fullName": "string",
          "uName": "string",
          "uPass": "string",
          "phone1": "string",
          "emailAdrs": "string",
          "adrsCity": "string",
          "usrCountry": "string",
          "gMaps": "string",
          "lastLoginDate": 0,
          "logoPNG": "string",
          "resetCode": "string",
          "isSysAdmin": true,
          "isActive1": true
        }));
  }

  static Future fetchTreatsTypes(BuildContext context) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    String id = await SharedPreferences.getInstance()
        .then((value) => value.getString('id') ?? '');
    http.Response response =
        await http.get(Uri.parse(getUsrTreatsTypes + '?uID=$id'), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    if (response.statusCode == 200) {
      var decodeData = json.decode(response.body);
      return decodeData;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('حدث خطا ما')));
    }
  }

  static Future queryTreatsTypes(BuildContext context,
      {required String query}) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    String id = await SharedPreferences.getInstance()
        .then((value) => value.getString('id') ?? '');
    http.Response response =
        await http.get(Uri.parse(getUsrTreatsTypes + "uid= $id"), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    print(getUsrTreatsTypes + "uid= $id");
    print('queryTreatsTypes ${response.body}');
    if (response.statusCode == 200) {
      var decodeData = json.decode(response.body);

      return decodeData;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('حدث خطا ما' + response.statusCode.toString())));
    }
  }

  Future updateUserTreatsTypes() async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    http.Response response = await http.post(Uri.parse(updateUsrTreatsTypes),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: json.encode({
          "baseSecurityParam": {"userKey": 0, "orgKey": 0, "roleKey": 0},
          "currentState": 0,
          "sortExpression": "string",
          "totalRecord": 0,
          "pageSize": 0,
          "currentPage": 0,
          "rowNumber": 0,
          "returnKey": 0,
          "uTTID": 0,
          "bID": 0,
          "uID": 0,
          "treatmentType": "string",
          "trtLenght": 0,
          "trtPrice": 0,
          "msg4Users": "string",
          "isActive1": true
        }));
  }

  static Future insertUsrTreatsTypes(BuildContext context,
      {required String treatmentType,
      required dynamic trtLenght,
      required bID}) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    String id = await SharedPreferences.getInstance()
        .then((value) => value.getString('id') ?? '');
    http.Response response = await http.post(Uri.parse(addUsrTreatsTypes),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: json.encode({
          "bID": bID,
          "uID": id,
          "treatmentType": treatmentType,
          "trtLenght": trtLenght,
          "trtPrice": 0,
          "msg4Users": "string",
          "isActive1": true
        }));
    print('queryTreatsTypes ${response.body}');
    if (response.statusCode == 200) {
      var decodeData = json.decode(response.body);
      return decodeData;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('حدث خطا ما' + response.statusCode.toString())));
    }
  }

  Future updateUserWorkHours() async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    http.Response response =
        await http.post(Uri.parse(updateUsrWorkHours), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    }, body: {
      "baseSecurityParam": {"userKey": 0, "orgKey": 0, "roleKey": 0},
      "currentState": 0,
      "sortExpression": "string",
      "totalRecord": 0,
      "pageSize": 0,
      "currentPage": 0,
      "rowNumber": 0,
      "returnKey": 0,
      "uWHID": 0,
      "bID": 0,
      "uID": 0,
      "workDate": 0,
      "dayOff": true,
      "shiftStrt": 0,
      "shiftEnds": 0,
      "isWorkShift": true,
      "mTLenght": 0,
      "mTPrice": 0,
      "msg4Users": "string",
      "isActive1": true
    });
  }

  Future insertUserWorkHours() async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    http.Response response = await http.post(Uri.parse(addUsrWorkHours),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: json.encode({
          "baseSecurityParam": {"userKey": 0, "orgKey": 0, "roleKey": 0},
          "currentState": 0,
          "sortExpression": "string",
          "totalRecord": 0,
          "pageSize": 0,
          "currentPage": 0,
          "rowNumber": 0,
          "returnKey": 0,
          "uWHID": 0,
          "bID": 0,
          "uID": 0,
          "workDate": 0,
          "dayOff": true,
          "shiftStrt": 0,
          "shiftEnds": 0,
          "isWorkShift": true,
          "mTLenght": 0,
          "mTPrice": 0,
          "msg4Users": "string",
          "isActive1": true
        }));
  }

  getAllUsrWorkHours(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String _token = preferences.getString('token') ?? '';

    http.Response response =
        await http.get(Uri.parse(getUsrWorkHours), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    if (response.statusCode == 200) {
    } else {
      showCupertinoDialog(
          context: context,
          builder: (context) => Text('حدث خطا ما ${response.statusCode}'));
    }
  }

  static Future<void> categoryy(
    BuildContext context,
  ) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');

    http.Response response =
        await http.get(Uri.parse(ApiLinks.index), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    if (response.statusCode == 200) {
      var decodeData = json.decode(response.body);

      return decodeData;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('حدث خطا ما' + response.statusCode.toString())));
    }
  }

  static Future query(BuildContext context, {String? query}) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    Uri uri = Uri.parse(ApiLinks.search);
    List list = [];
    uri.replace(queryParameters: {'phone': query});
    http.Response response = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
        "callMethod": "DOCTOR_AVAILABILITY"
      },
    );
    if (response.statusCode == 200) {
      Map decodedData = json.decode(response.body);
      decodedData.forEach((key, value) => list.add(value));
      
    }
    // list=await decodedData;

  }

  showEmployee(BuildContext context) {
    empolyee({required int index}) => Text('empolyee $index');
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              content: GridView.builder(
                  itemCount: 3,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => empolyee(index: index)),
            ));
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> login(BuildContext context,
      {required String phone, required String password}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CupertinoAlertDialog(
                content: CupertinoActivityIndicator(),
              ),
            ));
    http.Response response = await http.post(Uri.parse(ApiLinks.login),
        body: json.encode({"phone": phone, "password": password}),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      Navigator.pop(context);
      Map<String, dynamic> data = json.decode(response.body);
      LoginResponse loginResponse = LoginResponse.fromJson(data);

      if (loginResponse.data?.token != null) {
        print('token = ${loginResponse.data!.token}');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        preferences.setString('token', loginResponse.data!.token ?? '');
        preferences.setString('fullname', loginResponse.data!.fullname ?? '');
        preferences.setString('username', loginResponse.data!.username ?? '');
        preferences.setString('country', loginResponse.data!.country ?? '');
        preferences.setString('city', loginResponse.data!.city ?? '');
        preferences.setString('phone', loginResponse.data!.phone ?? '');

        navigatorOff(context, Home());
      }
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('حدث حطا ما' ' ' + response.statusCode.toString())));
    }
  }

  Future<void> register(BuildContext context,
      {required String phone,
      required String password,
      required String fullName,
      required String userName}) async {
    http.Response response = await http.post(Uri.parse(ApiLinks.register),
        body: json.encode({
          "phone": phone,
          "password": password,
          "fullname": fullName,
          "username": userName
        }),
        headers: {"Content-Type": "application/json"});
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CupertinoAlertDialog(
                content: CupertinoActivityIndicator(),
              ),
            ));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(" ${jsonResponse['message']}")));
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('حدث حطا ما' ' ' + response.statusCode.toString())));
    }
  }

  Future<List<DataFetchAllBusinessesModel>> fetchAllBusinesses(
      BuildContext context) async {
    List<DataFetchAllBusinessesModel> items = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String _token = preferences.getString('token') ?? '';
    http.Response response =
        await http.get(Uri.parse(ApiLinks.busineesGet), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    print('fetchAllBusinesses token=$_token');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      print(data);
      FetchAllBusinessesModel model = FetchAllBusinessesModel.fromJson(data);
      items = model.data!;
      return items;
    } else {
      showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                content: Text('حدث خطا ما  ${response.statusCode}'),
              ));
      return items;
    }
  }

  static Future<void> bussniseFetchAll(
      BuildContext context, categoryUid) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');

    http.Response response = await http
        .get(Uri.parse(ApiLinks.busineesIndex + categoryUid), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    print('Bussnise ${response.body}');
    if (response.statusCode == 200) {
      var decodeData = json.decode(response.body);

      return decodeData;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('حدث خطا ما' + response.statusCode.toString())));
    }
  }

  static logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    navigatorOff(context, const LoginPage());
  }

  // static sendSMS({required String phoneNumber, code}) {
  //   TwilioFlutter twilio = TwilioFlutter(
  //       accountSid: 'ACf8250c669d4270b27b45af8f940c0394',
  //       // replace *** with Account SID
  //       authToken: '6bda4370969cbabea75cdfc61aae5da4',
  //       // replace xxx with Auth Token
  //       twilioNumber: '+19362593318' // replace .... with Twilio Number
  //       );
  //   //twilioFlutter.sendSMS(toNumber: '+201090039634', messageBody: 'hello');
  //   twilio.sendSMS(toNumber: phoneNumber, messageBody: code);
  // }

  static List<Pages> listPage = [
    Pages(title: 'الرئيسيه', icon: Icons.home_filled, page: CategoryScreen()),
    Pages(title: 'حسابي', icon: Icons.person, page: UserProFile()),
    Pages(title: 'اعمالي', icon: Icons.monetization_on, page: MyBusiness()),
    Pages(title: 'انشئ مشروعك الخاص', icon: Icons.add, page: AddProject()),
    Pages(title: 'اوقات العمل ', icon: Icons.work, page: TimeWorkPlace()),
    Pages(title: 'عروض التوظيف', icon: Icons.work, page: MyEmployees()),
    Pages(title: 'تسجيل الخروج', icon: Icons.work, page: Logout()),
  ];

  static MaterialColor myColor = const MaterialColor(0xff808080, <int, Color>{
    50: Color(0xff808080),
    100: Color(0xff808080),
    200: Color(0xff808080),
    300: Color(0xff808080),
    400: Color(0xff808080),
    500: Color(0xff808080),
    600: Color(0xff808080),
    700: Color(0xff808080),
    800: Color(0xff808080),
    900: Color(0xff808080)
  });

  static navigatorGo(BuildContext context, Widget route) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => route));

  void selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (timeOfDay != null && timeOfDay != selectedTime) {
      selectedTime = timeOfDay;
    }
  }

  static navigatorOff(BuildContext context, Widget route) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => route));
}
