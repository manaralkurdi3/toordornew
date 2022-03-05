import 'package:flutter/material.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/Home.dart';
import 'package:toordor/View/Widget/TextForm.dart';
import 'package:toordor/View/Widget/background.dart';

import '../Widget/socialmedia.dart';

class SignIN extends StatelessWidget {
  SignIN({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Controller controller=Controller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        icon:const Icon(Icons.arrow_back_ios),
        onPressed: ()=>Navigator.pop(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Column(
        children: [
          Background(
            items: [
              const SizedBox(height: 30),
              TextForm(hint: 'البريد الالكتروني', controller: email),
              TextForm(hint: 'كلمه المرور', controller: password),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () =>controller.navigatorOff(context, Home()),
                  child: const Text(
                    'تسجيل الدخول',
                    style: TextStyle(color: Colors.white),
                  )),

            ],
          ),
          const SocialMedia()
        ],
      ),
    );
  }
}
