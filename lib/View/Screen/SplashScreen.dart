import 'package:flutter/material.dart';
import 'package:toordor/View/Screen/logintest.dart';
import 'package:toordor/const/color.dart';

import '../../Controller/Controller.dart';
import 'WelcomeScreen.dart';


class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Controller c = Controller();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3))
        .whenComplete(() => Controller.navigatorOff(context, LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: whiteColor,
        child: Image.asset('assets/4104e2aa-4c5b-417a-9507-ca86bc3a639b-removebg-preview.png',
          height: 70,
          width: 70,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}