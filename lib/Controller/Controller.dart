import 'package:flutter/material.dart';
import 'package:toordor/View/Screen/AddProject.dart';
import 'package:toordor/View/Widget/dialog.dart';
import 'package:toordor/const/color.dart';

class Controller {

  List<Pages> listPage = [
    Pages(title: 'الرئيسيه', icon: Icons.home_filled),
    Pages(title: 'حسابي', icon: Icons.person),
    Pages(title: 'اعمالي', icon: Icons.monetization_on),
    Pages(title: 'انشئ مشروعك الخاص', icon: Icons.add,page: AddProject())
  ];


  static MaterialColor myColor = const MaterialColor(0xff19a8e3, <int, Color>{
    50: Color(0xff19a8e2),
    100: Color(0xff19a8e3),
    200: Color(0xff19a8e4),
    300: Color(0xff19a8e5),
    400: Color(0xff19a8e6),
    500: Color(0xff19a8e7),
    600: Color(0xff19a8e8),
    700: Color(0xff19a8e9),
    800: Color(0xff19a8e2),
    900: Color(0xff19a8e4),
  });

  navigatorGo(BuildContext context, Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  navigatorOff(BuildContext context, Widget route) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => route));
  }


}
