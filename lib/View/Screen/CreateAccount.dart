import 'package:flutter/material.dart';
import 'package:toordor/Controller/Controller.dart';

import '../Widget/ImageButton.dart';
import '../Widget/TextForm.dart';

class SignUP extends StatelessWidget {
  SignUP({Key? key}) : super(key: key);
  Controller c = Controller();
  TextEditingController name = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Wrap(
        children: [
          Stack(
            alignment: const Alignment(0, 1.1),
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
                    height: h / 3,
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
                  height: h / 1.75,
                  child: Column(
                    children: [
                      SizedBox(height: h * 0.03),
                      TextForm(
                        hint: 'Full Name',
                        controller: name,
                        keyBoardType: TextInputType.name,
                      ),
                      TextForm(
                        hint: 'email',
                        controller: userName,
                        keyBoardType: TextInputType.emailAddress,
                      ),
                      TextForm(
                        hint: 'phoneNumber',
                        controller: phoneNumber,
                        keyBoardType: TextInputType.phone,
                      ),
                      TextForm(
                          hint: 'password',
                          controller: password,
                          visibility: true),
                      SizedBox(height: h * 0.03),
                      SizedBox(height: h * 0.01),
                      ElevatedButton(
                          child: SizedBox(
                              width: w / 1.8,
                              height: h / 20,
                              child: const Center(child: Text('Sign UP'))),
                          onPressed: () => c.navigatorGo(context, OTPScreen())),
                      SizedBox(height: h * 0.02),
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

class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key}) : super(key: key);
  TextEditingController otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextForm(hint: 'OPT Code', controller: otp),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: const Text('Submit'))
        ],
      ),
    );
  }
}
