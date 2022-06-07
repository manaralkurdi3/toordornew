import 'dart:math';
import 'package:flutter/material.dart';
import 'package:toordor/View/Widget/background.dart';
import 'package:toordor/View/Widget/headerbacground.dart';
import '../../Controller/Controller.dart';
import '../Widget/TextForm.dart';



import 'Home.dart';

class SignUP extends StatelessWidget {
  SignUP({Key? key}) : super(key: key);
  Controller c = Controller();
  TextEditingController name = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController Fullname = TextEditingController();
  double _headerHeight = 250;
  Controller controller = Controller();

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
          Column(
            children: [
              Container(
                height: _headerHeight,
                child: HeaderWidget(_headerHeight, true, Container(
                  child: Image.asset(
                      'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png'),
                ),
                ),
              ),
          TextForm(
            hint: 'الاسم بالكامل',
            controller: name,
            keyBoardType: TextInputType.name,
          ),
          TextForm(
            hint: 'اسم المستخدم  ',
            controller: Fullname,
            keyBoardType: TextInputType.name,
          ),
          /*TextForm(
            hint: 'البريد الالكتروني',
            controller: userName,
            keyBoardType: TextInputType.emailAddress,
          ),
          */
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
            style: ButtonStyle(
           //    backgroundColor: MaterialStateProperty.all(Colors.grey.shade400)
    ),
              child: SizedBox(
                  width: w / 1.8,
                  height: h / 20,
                  child: const Center(
                      child: Text(
                    'تسجيل الحساب',
                    style: TextStyle(color: Colors.white),
                  ))),
              onPressed: () async {
                controller.register(context,phone:phoneNumber.text,password: password.text,fullName: name.text,userName: Fullname.text);
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // registerapi(name.text.toString(), password.text,Fullname.text.toString(), phoneNumber.text.toString(),
                //     "780979842");

                //   Controller.navigatorGo(context, OTPScreen(phone: phoneNumber.text));
              }
          ),
        ],
      ),
    ]));
  }
}

class OTPScreen extends StatefulWidget {
  OTPScreen({Key? key,required this.phone}) : super(key: key);
 String phone;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otp = TextEditingController();
  late String code;
  String number='+201090039634';
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Random random =Random();
    code=random.nextInt(100000).toString();
    Controller.sendSMS(code: code,phoneNumber: number);
  }
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
              onPressed: () =>otp.text==code?Controller.navigatorOff(context,  Home()):null,
              child: const Text(
                'تأكيد',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
