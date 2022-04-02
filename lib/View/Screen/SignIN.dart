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
      body: FutureBuilder<List>(
     //   future: controller.rssToJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData == true) {
            return const Center(child: Text("لا توجد بيانات "));
          } else if (snapshot.hasData == false) {
            return Background(
              items: [
                // Expanded(
                //     child:
                //     ListView.builder(
                //      itemCount: snapshot.data?.length??0,
                //       itemBuilder: (context,i){
                //       if(snapshot.data!=null)  {
                //      return ListTile(
                //         title: Text(snapshot.data![i].fullName),
                //       );
                //     }else{
                //         return const Center(child: Text('k'),);
                //       }
                //   },
                // )),
                const SizedBox(height: 15),
                TextForm(hint: 'البريد الالكتروني', controller: email),
                TextForm(hint: 'كلمه المرور', controller: password),
                const SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () async {
                      List matchEmail = [];
                      List matchPassword = [];
                      matchEmail = snapshot.data!
                          .where((user) => user.uName == email)
                          .toList();
                      matchPassword = snapshot.data!
                          .where((user) => user.uPass == password)
                          .toList();
                      if (matchEmail.isNotEmpty && matchPassword.isNotEmpty) {
                        Controller.navigatorOff(context, Home());
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
                                  title: 'الحساب غير موجود',
                                  content: 'يرجى عمل حساب',
                                ));
                      }
                    },
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(color: Colors.white),
                    )),

              ],
            );
          } else {
            return const Center(child: Text('شي ما غامض!'));
          }
        },
      ),
    );
  }
}
