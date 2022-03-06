import 'package:flutter/material.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/CreateAccount.dart';
import 'package:toordor/View/Widget/dialog.dart';
import 'package:toordor/View/Widget/socialmedia.dart';
import 'package:toordor/const/color.dart';
import '../Widget/background.dart';
import 'SignIN.dart';

class Welcome extends StatelessWidget {
  Welcome({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Controller c = Controller();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Background(
        items: [
          SizedBox(height: h * .04),
          ElevatedButton(
              child: SizedBox(
                  width: w / 1.8,
                  height: h / 20,
                  child: const Center(
                      child: Text('تسجيل الدخول',
                          style:
                              TextStyle(fontSize: 16, color: Colors.white)))),
              onPressed: () =>
           c.navigatorGo(context,  SignIN())),
          SizedBox(height: h * 0.01),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor)),
              child: SizedBox(
                  width: w / 1.8,
                  height: h / 20,
                  child: const Center(
                      child: Text('عمل حساب',
                          style:
                              TextStyle(fontSize: 16, color: Colors.white)))),
              onPressed: () => c.navigatorGo(context, SignUP())),
          SizedBox(height: h * 0.01),

          SizedBox(height: h * 0.05),
        ],
      ),
    );
  }
}
