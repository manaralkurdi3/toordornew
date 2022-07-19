import 'dart:math';
import 'package:flutter/material.dart';
import 'package:toordor/view/widget/background.dart';
import 'package:toordor/view/widget/headerbacground.dart';
import 'package:toordor/const/components.dart';
import 'package:toordor/controller/size.dart';
import '../../controller/controller.dart';
import '../widget/TextForm.dart';

import 'home.dart';

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
  Key _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: Wrap(children: [
          Column(
            children: [
              Container(
                height: _headerHeight,
                child: HeaderWidget(
                  _headerHeight,
                  true,
                  Container(
                    child: Image.asset(
                        'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png'),
                  ),
                ),
              ),

              // TextForm(
              //   hint: 'الاسم بالكامل',
              //   controller: name,
              //   keyBoardType: TextInputType.name,
              // ),
              SizedBox(height: MySize.height(context) / 12),
              defualtTextFormField(
                  width: double.infinity,
                  controller: name,
                  type: TextInputType.name,
                  prefix: Icons.edit_outlined,
                  label: 'الاسم بالكامل',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يجب ادخال الاسم بالكامل';
                    }
                  }),
              const SizedBox(height: 15),
              defualtTextFormField(
                  width: double.infinity,
                  controller: Fullname,
                  type: TextInputType.name,
                  prefix: Icons.edit_outlined,
                  label: 'اسم المستخدم',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يجب ادخال اسم المستخدم';
                    }
                  }),

              // TextForm(
              //   hint: 'اسم المستخدم  ',
              //   controller: Fullname,
              //   keyBoardType: TextInputType.name,
              // ),
              /*TextForm(
            hint: 'البريد الالكتروني',
            controller: userName,
            keyBoardType: TextInputType.emailAddress,
          ),
          */
              const SizedBox(height: 15),
              Directionality(
                textDirection: TextDirection.ltr,
                child: defualtTextFormField(
                    width: double.infinity,
                    controller: phoneNumber,
                    type: TextInputType.phone,
                    suffix: Icons.phone,

                    label: 'رقم الهاتف',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يجب ادخال رقم الهاتف';
                      }
                    }),
              ),

              // TextForm(
              //   hint: 'رقم الهاتف',
              //   controller: phoneNumber,
              //   keyBoardType: TextInputType.phone,
              // ),
              // TextForm(
              //     hint: 'كلمه المرور', controller: password, visibility: true),
              const SizedBox(height: 15),
              defualtTextFormField(
                  controller: password,
                   password: true,
                  type: TextInputType.visiblePassword,
                  prefix: Icons.lock,
                  label: 'كلمه المرور',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يجب ادخال كلمة المرور ';
                    }
                  }),
              SizedBox(height: MySize.height(context) * 0.02),
              DefaultButton(
                  controll: () async {
                    await Controller.sendOTP(context, phone: phoneNumber.text)
                        .whenComplete(() => Controller.navigatorOff(
                            context,
                            OTPScreen(
                                phone: phoneNumber.text,
                                name: name.text,
                                password: password.text,
                                username: userName.text)));
                  },
                  text: 'تسجيل الحساب'),
              // ElevatedButton(
              //     style: ButtonStyle(
              //         //    backgroundColor: MaterialStateProperty.all(Colors.grey.shade400)
              //         ),
              //     child: SizedBox(
              //         width: w / 1.8,
              //         height: h / 20,
              //         child: const Center(
              //             child: Text(
              //           'تسجيل الحساب',
              //           style: TextStyle(color: Colors.white),
              //         ))),
              //     onPressed: () async {
              // controller.register(context,
              //     phone: phoneNumber.text,
              //     password: password.text,
              //     fullName: name.text,
              //     userName: Fullname.text);
              //       // SharedPreferences prefs = await SharedPreferences.getInstance();
              //       // registerapi(name.text.toString(), password.text,Fullname.text.toString(), phoneNumber.text.toString(),
              //       //     "780979842");

              //       //   Controller.navigatorGo(context, OTPScreen(phone: phoneNumber.text));
              //     }),
            ],
          ),
        ]));
  }
}

class OTPScreen extends StatefulWidget {
  const OTPScreen(
      {Key? key,
      required this.phone,
      required this.name,
      required this.username,
      required this.password})
      : super(key: key);
  final String phone, name, username, password;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otp = TextEditingController();
  late String code;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Random random =Random();
    // code=random.nextInt(100000).toString();
    //controller.sendSMS(code: code,phoneNumber: number);
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
              hint: 'كود التاكيد',
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
