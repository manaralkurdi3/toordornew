import 'package:flutter/material.dart';
import 'package:toordor/Controller/Controller.dart';

import 'View/Screen/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToorDor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Controller.myColor,
        fontFamily: 'Cairo',
      ),
      home:  SplashScreen(),
    );
  }
}

