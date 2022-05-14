import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/View/Screen/logintest.dart';

import 'View/Screen/Home.dart';
import 'View/Screen/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? email;
  String? password;
  String? date;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  email = preferences.getString('email');
  password = preferences.getString('password');
  date=preferences.getString('expiration');


// Define a simple format function from scratch
String simplyFormat({required String?  data, bool dateOnly = false}) {
   DateTime? time=DateTime.tryParse(data??'');


    String year = time?.year.toString()??'';

    // Add "0" on the left if month is from 1 to 9
    String month = time?.month.toString().padLeft(2, '0')??'';

    // Add "0" on the left if day is from 1 to 9
    String day = time?.day.toString().padLeft(2, '0')??'';

    // Add "0" on the left if hour is from 1 to 9
    String hour = time?.hour.toString().padLeft(2, '0')??'';

    // Add "0" on the left if minute is from 1 to 9
    String minute = time?.minute.toString().padLeft(2, '0')??'';

    // Add "0" on the left if second is from 1 to 9
    String second = time?.second.toString()??'';

    // If you only want year, month, and date
    if (dateOnly == false) {
      return "$year-$month-$day $hour:$minute.$second";
    }

   // return the "yyyy-MM-dd HH:mm:ss" format
   return "$year-$month-$day"' ${time?.hour}:${time?.minute}:${second[0]}.${time?.millisecond}';
 }
  print('now '+ DateTime.now().toString());
  print('date=='+ date.toString());
  DateTime? checkDate= DateTime.tryParse(date??'');
DateTime? last=DateTime.tryParse (simplyFormat(data: date,dateOnly: false));
last??DateTime.now();

    print('last='+last.toString());
//******************************************************************************//

  // DateTime parseDate =
  //  DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date??'');
  // var inputDate = DateTime.parse(parseDate.toString());
  // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
  // var outputDate = outputFormat.format(inputDate);
  // print('outputDate'+outputDate);
  // DateTime last=DateTime.parse(outputDate);
  //******************************************************************************//
  // if(date!=null && checkDate!=null&&checkDate.isBefore(DateTime.now())){
  //   if(email!=null&&password!=null){
  //     runApp(MyApp());
  //   }else{
  //     runApp(App());
  //   }
  //
  // }else{
  //   runApp(App());
  // }
  runApp(App());
}

class MyApp extends StatelessWidget {
  Color _primaryColor = HexColor('#808080');
  Color _accentColor = HexColor('#808080');

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {

      return MaterialApp(
        title: 'ToorDor',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ar', 'EG')],
        theme: ThemeData(
          primaryColor: _primaryColor,
          accentColor: _accentColor,
          scaffoldBackgroundColor: Colors.grey.shade100,
          primarySwatch: Colors.grey,
        ),
        home: SplashScreen(route:Home()),
      );
    });
  }
}
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {

      return MaterialApp(
        title: 'ToorDor',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ar', 'EG')],
        theme: ThemeData(

          scaffoldBackgroundColor: Colors.grey.shade100,
          primarySwatch: Colors.grey,
        ),
        home: SplashScreen(route:const LoginPage()),
      );
    });
  }
}
