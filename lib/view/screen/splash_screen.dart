import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/const/color.dart';

import '../../Controller/controller.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.route}) : super(key: key);
  Widget route;


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String _hasbussnise;
  getData() async => await Future.delayed(const Duration(seconds: 2))
      .whenComplete(() => Controller.navigatorOff(context, widget.route));
  shared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _hasbussnise = await SharedPreferences.getInstance()
        .then((value) => value.getString('has_bussinees') ?? '');
    print(_hasbussnise);
  }
  @override
  void initState() {
    Controller.userData(context);
    shared();
    super.initState();
    Future.delayed(const Duration(seconds: 3)).whenComplete(() => getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: whiteColor,
        child: Image.asset(
            'assets/4104e2aa-4c5b-417a-9507-ca86bc3a639b-removebg-preview.png',
            height: 70,
            width: 70),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
