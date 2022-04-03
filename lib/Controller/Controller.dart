import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toordor/Model/users.dart';
import 'package:toordor/View/Screen/AddProject.dart';
import 'package:toordor/View/Screen/MyBusiness.dart';
import 'package:toordor/View/Screen/UserProfile.dart';
import 'package:toordor/View/Screen/homeBody.dart';
import 'package:toordor/View/Widget/dialog.dart';
import 'package:toordor/const/color.dart';
import 'package:http/http.dart' as http;


class Controller {
   static List<dynamic> category = [
    'assets/instagram.png',
     'assets/instagram.png',
     'assets/instagram.png',
     'assets/instagram.png',
     'assets/instagram.png',
     'assets/instagram.png',
     'assets/instagram.png',
     'assets/instagram.png',
     'assets/instagram.png',
     'assets/instagram.png',
     'assets/instagram.png',
     'assets/instagram.png',
     'assets/instagram.png',
     'assets/instagram.png',
     'assets/instagram.png',
     'assets/instagram.png',
  ];
  TimeOfDay selectedTime = TimeOfDay.now();
  Future rssToJson() async{
    List<Users> data=[];
    String url='http://toordor.com/api/Users';
    try {
      var response = await http.get(Uri.parse(url));


      data.add(Users.fromJson(json.decode(response.body)));
      print(data[0].phone1);
     // );
    } catch (e) {
      print(e);
    }

  }

  // Future<List> fetchUsersFormDB(BuildContext context) async {
  //   String url = 'http://toordor.com/api/Users';
  //   List listUsers = [];
  //   var xml;
  //   http.Response response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     showDialog(
  //         context: context,
  //         builder: (context) => MyDialog(
  //               hasError: false,
  //               title: 'الاتصال طبيعي',
  //               content: 'رقم الرد ${response.statusCode}',
  //             ));
  //    var xmlCom = XmlDocument.parse(response.body);
  //    xml=xmlCom.findAllElements("User");
  //     print(xml);
  //     listUsers.add(Users.fromXml(xml));
  //     return listUsers;
  //   } else {
  //     showDialog(
  //         context: context,
  //         builder: (context) => CupertinoAlertDialog(
  //               content: Text(response.statusCode.toString()),
  //             ));
  //   }
  //   return listUsers;
  // }

  List<Pages> listPage = [
    Pages(title: 'الرئيسيه', icon: Icons.home_filled,page: HomeBody()),
    Pages(title: 'حسابي', icon: Icons.person,page: UserProFile()),
    Pages(title: 'اعمالي', icon: Icons.monetization_on,page: MyBusiness()),
    Pages(title: 'انشئ مشروعك الخاص', icon: Icons.add, page: AddProject()),
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

  static navigatorGo(BuildContext context, Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

   void selectTime(BuildContext context) async {

    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,

    );

    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      selectedTime = timeOfDay;

    }

  }

 static navigatorOff(BuildContext context, Widget route) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => route));
  }
}
