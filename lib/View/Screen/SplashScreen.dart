import 'package:flutter/material.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/HomeScreen.dart';

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
     Future.delayed(const Duration(seconds: 5))
         .whenComplete(() => c.navigatorOff(context, HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.pink,
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
