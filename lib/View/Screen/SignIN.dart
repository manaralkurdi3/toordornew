import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/Model/users.dart';
import 'package:toordor/View/Screen/Home.dart';
import 'package:toordor/View/Widget/TextForm.dart';
import 'package:toordor/View/Widget/background.dart';
import 'package:toordor/View/Widget/dialog.dart';

class SignIN extends StatelessWidget {
  SignIN({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Controller controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: FutureBuilder<List<Users>>(
        future: controller.fetchUsersFormDB(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CupertinoActivityIndicator());
          } else if(snapshot.hasData==false){
            return Center(child: Text("لا توجد بيانات "));
          }else {

            return Background(
              items: [
                const SizedBox(height: 30),
                TextForm(hint: 'البريد الالكتروني', controller: email),
                TextForm(hint: 'كلمه المرور', controller: password),
                const SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () async {
                      List matchEmail = [];
                      List matchPassword = [];
                      matchEmail = snapshot.data!
                          .where((element) => element.uName == email)
                          .toList();
                      matchPassword = snapshot.data!
                          .where((element) => element.uPass == password)
                          .toList();
                      if (matchEmail.isNotEmpty && matchPassword.isNotEmpty) {
                        controller.navigatorOff(context, Home());
                      } else if (matchEmail.isNotEmpty &&
                          matchPassword.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) => MyDialog(
                                  hasError: true,
                                  title: 'كلمه المرور خطا ',
                                  content: 'حاول مرة اخرى ',
                                ));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => MyDialog(
                                  hasError: true,
                                  title: 'الحساب غير موجو,  ',
                                  content: 'يرجى عمل حساب ',
                                ));
                      }
                    },
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            );
          }
        },
      ),
    );
  }
}
