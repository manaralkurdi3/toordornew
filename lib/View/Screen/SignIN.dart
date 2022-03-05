import 'package:flutter/material.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/CreateAccount.dart';
import 'package:toordor/View/Screen/Home.dart';
import 'package:toordor/View/Widget/ImageButton.dart';
import 'package:toordor/View/Widget/TextForm.dart';
import 'package:toordor/const/color.dart';

import '../Widget/background.dart';
import 'ForgetPassword.dart';

class SignIN extends StatelessWidget {
  SignIN({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Controller c = Controller();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Background(items: [

        SizedBox(height: h * .1),
        ElevatedButton(
            child: SizedBox(
                width: w / 1.8,
                height: h / 20,
                child: const Center(child: Text('Login'))),
            onPressed: () =>
                c.navigatorOff(context,  Home())),
        SizedBox(height: h * 0.01),
        ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)),
            child: SizedBox(
                width: w / 1.8,
                height: h / 20,
                child: const Center(child: Text('Sign UP'))),
            onPressed: () => c.navigatorGo(context,SignUP())),
        SizedBox(height: h * 0.1),
        Stack(
          alignment: Alignment.center,
          children: [
            const Divider(thickness: 2),
            Container(
              padding: const EdgeInsets.all(9),
              color: Colors.white,
              child: const Text(
                'Login With',
                style: TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
        SizedBox(height: h * 0.04),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HomeButton(image: 'assets/google.png'),
              HomeButton(image: 'assets/facebook.png'),
              HomeButton(image: 'assets/instagram.png')
            ],
          ),
        )
      ],),
    );
  }
}


