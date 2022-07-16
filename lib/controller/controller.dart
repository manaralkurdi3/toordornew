import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:toordor/model/login_model.dart';
import 'package:toordor/view/Screen/add_project.dart';
import 'package:toordor/view/screen/home.dart';
import 'package:toordor/view/screen/my_business.dart';
import 'package:toordor/view/screen/my_employees.dart';
import 'package:toordor/view/screen/user_profile.dart';
import 'package:toordor/view/screen/time_workplace.dart';
import 'package:toordor/const/color.dart';
import 'package:http/http.dart' as http;
import 'package:toordor/const/new_url_links.dart';
import 'package:toordor/const/urlLinks.dart';
import 'package:toordor/View/screen/home_body_category.dart';

import '../view/screen/logout_screen.dart';
import '../model/employee_services.dart';
import '../model/services.dart';
import '../view/screen/login_screen.dart';

class Controller {
 static dynamic setPage;
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

  static Future userData(BuildContext context) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    // String id = await SharedPreferences.getInstance()
    //     .then((value) => value.getString('id') ?? '');
    // String username = await SharedPreferences.getInstance()
    //     .then((value) => value.getString('username') ?? '');
    // print(username);

    Map<String, String> header = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    http.Response response =
        await http.get(Uri.parse(ApiLinks.user), headers: header);
    if (response.statusCode == 200) {
      var decodeData = json.decode(response.body);
      return decodeData;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('حدث خطأ ما!')));
    }
  }

  static Future<List<Appointment>> getAppointments(
    BuildContext context,
    dynamic businessId,
    employeeId,
    date,
    fromDate,
    toDate,
    comment,
  ) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    Map<String, String> header = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    http.Response response =
        await http.get(Uri.parse(ApiLinks.book + businessId), headers: header);
    List<Appointment> meetings = <Appointment>[];
    final DateTime today = DateTime.now();
    final DateTime fromDate = DateTime(today.year, today.month, today.day);
    final DateTime toDate = fromDate.add(
      const Duration(hours: 2),
    );
    meetings.add(Appointment(
      startTime: fromDate,
      endTime: toDate,
      subject: 'newappointment',
      color: Colors.blue,
    ));
    return meetings;
  }

  static Future<List<ServicesIndexOfbussnise>> servicesIndex(
      BuildContext context, dynamic bussniseId) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    // String id = await SharedPreferences.getInstance()
    //     .then((value) => value.getString('id') ?? '');
    // String username = await SharedPreferences.getInstance()
    //     .then((value) => value.getString('username') ?? '');
    // print(username);

    Map<String, String> header = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    http.Response response = await http
        .get(Uri.parse(ApiLinks.serviceIndex + bussniseId), headers: header);

    List<ServicesIndexOfbussnise> serviceindex = [];
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data["data"] as List;
      // var error = data['error'];
      serviceindex = rest
          .map<ServicesIndexOfbussnise>(
              (json) => ServicesIndexOfbussnise.fromJson(json))
          .toList();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('حدث خطأ ما!')));
      return serviceindex;
    }
    return serviceindex;

    // var decodeData = json.decode(response.body);
    //
    // serviceindex.add(
    //     ServicesIndexOfbussnise.fromJson(decodeData['data'])
    // );
    // return serviceindex;
  }

  static Future<List<ServicesEmployee>> servicesEmployee(
      BuildContext context, String employeeId) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    // String id = await SharedPreferences.getInstance()
    //     .then((value) => value.getString('id') ?? '');
    // String username = await SharedPreferences.getInstance()
    //     .then((value) => value.getString('username') ?? '');
    // print(username);

    Map<String, String> header = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    http.Response response = await http
        .get(Uri.parse(ApiLinks.serviceEmploy + employeeId), headers: header);

    List<ServicesEmployee> serviceEmployee = [];
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      List rest = data['message']["data"];
      // var error = data['error'];
      serviceEmployee = rest
          .map<ServicesEmployee>((json) => ServicesEmployee.fromJson(json))
          .toList();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('حدث خطأ ما!')));
      return serviceEmployee;
    }
    return serviceEmployee;

    // var decodeData = json.decode(response.body);
    //
    // serviceindex.add(
    //     ServicesIndexOfbussnise.fromJson(decodeData['data'])
    // );
    // return serviceindex;
  }

  static Future userDataEdit(
    BuildContext context, {
    required TextEditingController fulname,
    required TextEditingController phone,
    required TextEditingController city,
    required TextEditingController name,
    required TextEditingController country,
  }) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    // String id = await SharedPreferences.getInstance()
    //     .then((value) => value.getString('id') ?? '');
    // String username = await SharedPreferences.getInstance()
    //     .then((value) => value.getString('username') ?? '');
    // print(username);

    Map<String, String> header = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    http.Response response = await http.post(Uri.parse(ApiLinks.editUser),
        headers: header,
        body: jsonEncode({
          "fullname": fulname.text,
          "username": name.text,
          "phone": phone.text,
          "country_id": country.text,
          "city_id": city.text,
        }));
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('تم تعديل البيانات ')));

      Navigator.pop(context);
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

  Future insertBusiness(
    BuildContext context, {
    required String phoneNumber,
    required String nameProject,
    required String specialization,
    required String email,
    required setState,
    String? country,
    String? city,
    required String fromt,
    required String tot,
  }) async {
    setPage(0);
    // String _token = await SharedPreferences.getInstance()
    //     .then((value) => value.getString('token') ?? '');
    //
    // Map<String, String> header = {
    //   "Content-Type": "application/json",
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer $_token',
    // };
    // Uri uri = Uri.parse(ApiLinks.busineesCreate);
    //
    // http.Response response = await http.post(uri,
    //     headers: header,
    //     body: json.encode({
    //       "business_name": nameProject,
    //       "phone": phoneNumber,
    //       "email": email,
    //       "specialization": specialization,
    //       "weekends": "",
    //       "from_date": fromt,
    //       "to_date": tot,
    //       "country_id": country,
    //       "city_id": 2
    //     }));
    //
    // if (response.statusCode == 200) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text('تمت الاضافه بنجاح'),
    //     backgroundColor: Colors.green,
    //   ));
    //
    //   setstate(()=>Home.indexPage=2);
    // } else {
    //   showDialog(
    //       context: context,
    //       builder: (context) => CupertinoAlertDialog(
    //             content: Text('حدث خطا ما ${response.statusCode}'),
    //           ));
    // }
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

  static Future getServiceEmployee(BuildContext context) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    String id = await SharedPreferences.getInstance()
        .then((value) => value.getString('id') ?? '');
    http.Response response = await http
        .get(Uri.parse(ApiLinks.getServicesEmployees + '?uID=$id'), headers: {
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

  // static Future fetchTreatsTypes(BuildContext context) async {
  //   String _token = await SharedPreferences.getInstance()
  //       .then((value) => value.getString('token') ?? '');
  //   String id = await SharedPreferences.getInstance()
  //       .then((value) => value.getString('id') ?? '');
  //   http.Response response =
  //       await http.get(Uri.parse(getUsrTreatsTypes + '?uID=$id'), headers: {
  //     "Content-Type": "application/json",
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $_token',
  //   });
  //   if (response.statusCode == 200) {
  //     var decodeData = json.decode(response.body);
  //     return decodeData;
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('حدث خطا ما')));
  //   }
  // }

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

  static Future createNewService(BuildContext context,
      {required String treatmentType,
      required String trtLenght,
      required bID}) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    String id = await SharedPreferences.getInstance()
        .then((value) => value.getString('id') ?? '');
    http.Response response =
        await http.post(Uri.parse(ApiLinks.createNewServices),
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
    if (response.statusCode == 200) {
      var decodeData = json.decode(response.body);
      return decodeData;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('حدث خطا ما' + response.statusCode.toString())));
    }
  }

  // static Future insertUsrTreatsTypes(BuildContext context,
  //     {required String treatmentType,
  //     required dynamic trtLenght,
  //     required bID}) async {
  //   String _token = await SharedPreferences.getInstance()
  //       .then((value) => value.getString('token') ?? '');
  //   String id = await SharedPreferences.getInstance()
  //       .then((value) => value.getString('id') ?? '');
  //   http.Response response = await http.post(Uri.parse(addUsrTreatsTypes),
  //       headers: {
  //         "Content-Type": "application/json",
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $_token',
  //       },
  //       body: json.encode({
  //         "bID": bID,
  //         "uID": id,
  //         "treatmentType": treatmentType,
  //         "trtLenght": trtLenght,
  //         "trtPrice": 0,
  //         "msg4Users": "string",
  //         "isActive1": true
  //       }));
  //   if (response.statusCode == 200) {
  //     var decodeData = json.decode(response.body);
  //     return decodeData;
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('حدث خطا ما' + response.statusCode.toString())));
  //   }
  // }

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
    } else {
      print('api error');
    }
    return list;
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

  Future<dynamic> fetchAllBusinesses(BuildContext context) async {
    //  List<DataFetchAllBusinessesModel> items = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String _token = preferences.getString('token') ?? '';
    http.Response response =
        await http.get(Uri.parse(ApiLinks.busineesGet), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      // FetchAllBusinessesModel model = FetchAllBusinessesModel.fromJson(data);
      //  items = model.data!;
      return;
    } else {
      showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                content: Text('حدث خطا ما  ${response.statusCode}'),
              ));
      return;
    }
  }

  static Future bussniseFetchAll(
      BuildContext context, dynamic categoryUid) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');

    http.Response response = await http
        .get(Uri.parse(ApiLinks.busineesIndex + categoryUid), headers: {
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
    Pages(title: 'الرئيسيه', icon: Icons.home_filled, page: HomeBody()),
    //Pages(title: 'بزنس', icon: Icons.home_filled, page: HomeBody1("")),
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
