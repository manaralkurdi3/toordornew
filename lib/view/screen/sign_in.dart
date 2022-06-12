import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toordor/Controller/controller.dart';
import 'package:toordor/Model/users.dart';
import 'package:toordor/View/Screen/home.dart';
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
                TextForm(hint: 'رقم الهاتف', controller: email),
                TextForm(hint: 'كلمه المرور', controller: password,visibility: true),
                const SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () async {
          //controller.fetchAllUsers(context, email.text),
          },
                       // controller.login(context, user: email.text, password: password.text),
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(color: Colors.white),
                    )),
               // ElevatedButton(child: Text('Send SMS'),onPressed: ()=>controller.sendSMS(),)
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
