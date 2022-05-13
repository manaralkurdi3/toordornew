import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/Model/login_model.dart';
import 'package:toordor/View/Screen/AddProject.dart';
import 'package:toordor/View/Screen/Home.dart';
import 'package:toordor/View/Screen/MyBusiness.dart';
import 'package:toordor/View/Screen/MyEmployees.dart';
import 'package:toordor/View/Screen/UserProfile.dart';
import 'package:toordor/View/Screen/homeBody.dart';
import 'package:toordor/const/color.dart';
import 'package:http/http.dart' as http;
import 'package:toordor/const/urlLinks.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import '../Model/fetch_all_businesses.dart';

class Controller {

  Future updateBusiness(BuildContext context,
      {
        required String phoneNumber, required String nameProject,required String specilization,required String email,
        required String country , required String city} )async{
    String _token=await SharedPreferences.getInstance().then((value) => value.getString('token')??'');
    Map<String,String> header={
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    http.Response response=await http.post(Uri.parse(updateBusinesses),headers: header,body: json.encode(
        {
          "uID": phoneNumber,
          "bFullName": nameProject,
          "bPhone1": phoneNumber,
          "bEmailAdrs": email,
          "adrsCity":city,
          "bCountry":country,
          "logoPNG": null,
          "bBranch1": specilization,
          "isActive1": true
        }

    ));
    if(response.statusCode==200){
      Navigator.pop(context);
    }else{
      showDialog(context: context, builder: (context)=>CupertinoAlertDialog(
        content: Text('حدث خطا ما ${response.statusCode}'),
      ));
    }
  }

  Future insertBusiness(BuildContext context,
      {
        required String phoneNumber, required String nameProject,required String specilization,required String email,
        required String country , required String city} )async{
    String _token=await SharedPreferences.getInstance().then((value) => value.getString('token')??'');
    Map<String,String> header={
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    http.Response response=await http.post(Uri.parse(addBusinesses),headers: header,body: json.encode(
        {
          "uID": phoneNumber,
          "bFullName": nameProject,
          "bPhone1": phoneNumber,
          "bEmailAdrs": email,
          "adrsCity":city,
          "bCountry":country,
          "logoPNG": null,
          "bBranch1": specilization,
          "isActive1": true
        }

    ));
    if(response.statusCode==200){
      showDialog(context: context, builder: (context)=>CupertinoAlertDialog(
        content: Text('تمت الاضافه بنجاح'),
        actions: [
          ElevatedButton(onPressed: ()=>Navigator.pop(context), child: const Text('اغلاق'))
        ],
      ));
    }else{
      showDialog(context: context, builder: (context)=>CupertinoAlertDialog(
        content: Text('حدث خطا ما ${response.statusCode}'),
      ));
    }

  }

  Future fetchBusiRequists()async{
    String _token=await SharedPreferences.getInstance().then((value) => value.getString('token')??'');
   http.Response response=await http.get(Uri.parse(getAllBusiRequists),headers:  {
     "Content-Type": "application/json",
     'Accept': 'application/json',
     'Authorization': 'Bearer $_token',
   });
  }

  Future updateBusiRequists()async{
    String _token=await SharedPreferences.getInstance().then((value) => value.getString('token')??'');
    http.Response response=await http.post(Uri.parse(updateBusinesses),headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    },body:
    json.encode(
        {
          "baseSecurityParam": {
            "userKey": 0,
            "orgKey": 0,
            "roleKey": 0
          },
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
        }
    )

    );
  }
  Future insertBusiRequists()async{
    String _token=await SharedPreferences.getInstance().then((value) => value.getString('token')??'');
    http.Response response=await http.post(Uri.parse(addBusiRequists),headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    },body:
        json.encode(
            {
              "baseSecurityParam": {
                "userKey": 0,
                "orgKey": 0,
                "roleKey": 0
              },
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
            }
        )

    );
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

  Future fetchTreatsTypes() async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    http.Response response =
        await http.get(Uri.parse(getUsrTreatsTypes), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
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

  Future insertUsrTreatsTypes() async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    http.Response response = await http.post(Uri.parse(addUsrTreatsTypes),
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

  showEmployee(BuildContext context) {
    empolyee({required int index}) => Container(
          child: Text('empolyee $index'),
        );
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              content: GridView.builder(
                  itemCount: 3,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => empolyee(index: index)),
            ));
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> login(BuildContext context,
      {required String user, password}) async {
    http.Response response = await http.post(Uri.parse(authLogin),
        body: json.encode({"username": user, "password": password}),
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
      Navigator.pop(context);
      Map<String, dynamic> data = json.decode(response.body);
      LoginResponse loginResponse = LoginResponse.fromJson(data);
      print('token = ${loginResponse.data!.token}');
      if (loginResponse.data?.token != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        preferences.setString('token', loginResponse.data!.token ?? '');
        preferences.setString('name', loginResponse.data!.username ?? '');
       String encodeEmail=json.encode(user);
       String encodePassword=json.encode(password);
       preferences.setString('expiration', loginResponse.data!.expiration??'');
       preferences.setString('email', encodeEmail);
       preferences.setString('password', encodePassword);
     navigatorOff(context, Home());
      }
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
    http.Response response = await http.get(Uri.parse(getBusinesses), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    print('fetchAllBusinesses token=$_token');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
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

  static sendSMS({required String phoneNumber, code}) {
    TwilioFlutter twilio = TwilioFlutter(
        accountSid: 'ACf8250c669d4270b27b45af8f940c0394',
        // replace *** with Account SID
        authToken: '6bda4370969cbabea75cdfc61aae5da4',
        // replace xxx with Auth Token
        twilioNumber: '+19362593318' // replace .... with Twilio Number
        );
    //twilioFlutter.sendSMS(toNumber: '+201090039634', messageBody: 'hello');
    twilio.sendSMS(toNumber: phoneNumber, messageBody: code);
  }

  static List<Pages> listPage = [
    Pages(title: 'الرئيسيه', icon: Icons.home_filled, page: HomeBody()),
    Pages(title: 'حسابي', icon: Icons.person, page: UserProFile()),
    Pages(title: 'اعمالي', icon: Icons.monetization_on, page: MyBusiness()),
    Pages(title: 'انشئ مشروعك الخاص', icon: Icons.add, page: AddProject()),
    Pages(title: 'عروض التوظيف', icon: Icons.work, page: MyEmployees())
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
    900: Color(0xff808080),
  });

  static navigatorGo(BuildContext context, Widget route) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => route));

  void selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (timeOfDay != null && timeOfDay != selectedTime) {
      selectedTime = timeOfDay;
    }
  }

  static navigatorOff(BuildContext context, Widget route) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => route));
}
