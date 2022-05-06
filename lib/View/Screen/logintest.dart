import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/CreateAccount.dart';
import 'package:toordor/View/Screen/Home.dart';
import 'package:toordor/View/Screen/homeBody.dart';
import 'package:toordor/View/Widget/TextForm.dart';
import 'package:toordor/View/Widget/headerbacground.dart';
import 'package:toordor/View/Widget/socialmedia.dart';


class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  double _headerHeight = 250;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Controller controller = Controller();
  Key _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Container(
                child: Image.asset(
                        'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png'),
                  ),
                ),
              ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                //  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                  child: Column(
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                                    children: [
                                      TextForm(hint: 'البريد الالكتروني', controller: email),
                                      TextForm(hint: 'كلمه المرور', controller: password),
                                      const SizedBox(height: 15),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(10,0,10,20),
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            // Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                          },
                                          child: Text( "هل نسيت كلمة المرور؟", style: TextStyle( color: Colors.grey, ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: ElevatedButton(
                                            onPressed: () async {
                                          //  print(snapshot.data.toString()+"bkhvjdkc") ;
                                             // controller.fetchAllUsers(context, email.text);
                                              controller.login(context,user:email.text,password: password.text);
                                            },
                                          // controller.login(context, user: email.text, password: password.text),
                                            child:  Text(
                                              'تسجيل الدخول',
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(10,20,10,20),
                                        //child: Text('Don\'t have an account? Create'),
                                        child: Text.rich(
                                            TextSpan(
                                                children: [
                                                  TextSpan(text: "ليس لديك حساب ؟ "),
                                                  TextSpan(
                                                    text: 'أنشاء',
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUP()));
                                                      },
                                                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                                  ),
                                                ]
                                            )
                                        ),
                                      ),
                                      Container(
                                        child: SocialMedia(),
    )


]))])))])));}
}
class ThemeHelper {
  buttonStyle() {}
}