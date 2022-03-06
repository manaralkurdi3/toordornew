import 'package:flutter/material.dart';
import 'package:toordor/View/Widget/background.dart';
import 'package:toordor/const/color.dart';

import '../../Controller/Controller.dart';
import '../Widget/ImageButton.dart';
import '../Widget/TextForm.dart';
import '../Widget/socialmedia.dart';

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
      extendBodyBehindAppBar: true,
      floatingActionButton: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Wrap(
        children: [
          Stack(
            alignment: const Alignment(0, .3),
            children: [
              Column(
                children: [
                  Container(
                    alignment: const Alignment(0, -.4),
                    child: Image.asset(
                      'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png',
                      // fit: BoxFit.fill,
                    ),
                    width: w,
                    height: h / 2,
                    decoration: const BoxDecoration(
                        color: primaryColor,
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
                        hint: 'الاسم بالكامل',
                        controller: name,
                        keyBoardType: TextInputType.name,
                      ),
                      TextForm(
                        hint: 'البريد الالكتروني',
                        controller: userName,
                        keyBoardType: TextInputType.emailAddress,
                      ),
                      TextForm(
                        hint: 'رقم الهاتف',
                        controller: phoneNumber,
                        keyBoardType: TextInputType.phone,
                      ),
                      TextForm(
                          hint: 'كلمه المرور',
                          controller: password,
                          visibility: true),
                      SizedBox(height: h * 0.01),
                      SizedBox(height: h * 0.01),
                      ElevatedButton(
                          child: SizedBox(
                              width: w / 1.8,
                              height: h / 20,
                              child: const Center(
                                  child: Text(
                                'تسجيل الحساب',
                                style: TextStyle(color: Colors.white),
                              ))),
                          onPressed: () => c.navigatorGo(context, OTPScreen())),
                      SizedBox(height: h * 0.02),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: h / 1.4),
                 // const SocialMedia(),
                ],
              )
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
      floatingActionButton: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Background(
        items: [
          const SizedBox(height: 60),
          TextForm(
              hint: 'كود الحساب',
              controller: otp,
              keyBoardType: TextInputType.phone),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {},
              child: const Text(
                'تأكيد',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
