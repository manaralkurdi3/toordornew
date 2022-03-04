import 'package:flutter/material.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/CreateAccount.dart';
import 'package:toordor/View/Screen/Home.dart';
import 'package:toordor/View/Widget/ImageButton.dart';
import 'package:toordor/View/Widget/TextForm.dart';

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
      body: Wrap(
        children: [
          Stack(
            alignment: const Alignment(0, .6),
            children: [
              Column(
                children: [
                  Container(
                    child: Image.asset(
                      'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png',
                      height: 100,
                      width: 100,
                    ),
                    width: w,
                    height: h / 2,
                    decoration: const BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18))),
                  ),
                  SizedBox(height: h / 2)
                ],
              ),
              Card(
                elevation: 22,
                color: Colors.pink.withOpacity(0),
                child: Container(
                  width: w / 1.2,
                  height: h / 1.92,
                  child: Column(
                    children: [
                      SizedBox(height: h * 0.03),
                      TextForm(
                        hint: 'email',
                        controller: email,
                        keyBoardType: TextInputType.emailAddress,
                      ),
                      TextForm(
                          hint: 'password',
                          controller: password,
                          visibility: true),
                      TextButton(
                          onPressed: () =>
                              c.navigatorGo(context,  ForgetPassword()),
                          child: const Text('Forget Password?')),
                      SizedBox(height: h * 0.01),
                      ElevatedButton(
                          child: SizedBox(
                              width: w / 1.8,
                              height: h / 20,
                              child: const Center(child: Text('Login'))),
                          onPressed: () =>
                              c.navigatorOff(context,  Home())),
                      SizedBox(height: h * 0.01),
                      ElevatedButton(
                          child: SizedBox(
                              width: w / 1.8,
                              height: h / 20,
                              child: const Center(child: Text('Sign UP'))),
                          onPressed: () => c.navigatorGo(context, SignUP())),
                      SizedBox(height: h * 0.02),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const Divider(thickness: 3),
                          Container(
                            padding: const EdgeInsets.all(7),
                            color: Colors.white,
                            child: const Text(
                              'Login With',
                              style: TextStyle(fontSize: 17),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: h * 0.01),
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
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


