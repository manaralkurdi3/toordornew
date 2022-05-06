import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
class Registration extends StatefulWidget{
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Permission permission=  Permission.sms;
    permission.request();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Auto SMS Read"),
        backgroundColor: Colors.purple,),
      body: Center(
        child: Container(
          color: Colors.purple,
          child: ElevatedButton(
            onPressed: () async {

            final signature=await SmsAutoFill().getAppSignature;
              print(signature);
              Navigator.push(context, MaterialPageRoute(builder: (context){

                return OTP();
              }));
            },

            child: Text("Registration/Login",  style: TextStyle(fontSize: 20, color: Colors.white)),

          ),
        ),
      ),
    );
  }
}

class OTP extends StatefulWidget {
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listOPT();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Auto SMS Read"),
        backgroundColor: Colors.purple,),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Enter PIN"),
              Container(
                child:  PinFieldAutoFill(
                  decoration: UnderlineDecoration(
                    textStyle: TextStyle(fontSize: 20, color: Colors.black),
                    colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                  ),
                  codeLength: 4,
                  onCodeSubmitted: (code) {},
                  onCodeChanged: (code) {
                    if (code!.length == 6) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _listOPT()
  async {
    await SmsAutoFill().listenForCode;
  }
}