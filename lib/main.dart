import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/view/screen/login_screen.dart';


import 'View/Screen/home.dart';
import 'View/Screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool data = preferences.getString('token') == null;
  runApp(MyApp(route: data));
}

class MyApp extends StatelessWidget {
  bool route;

  MyApp({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'ToorDor',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [Locale('ar', 'EG')],
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade100,
          primarySwatch: Colors.grey,
        ),
        home: SplashScreen(route: route ? const LoginPage() : Home()),
      );
    });
  }
}
