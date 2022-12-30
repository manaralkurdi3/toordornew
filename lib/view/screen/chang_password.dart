import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/controller/controller.dart';
import 'package:toordor/controller/size.dart';
import 'package:toordor/view/widget/TextForm.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController password = TextEditingController(),
      rePassword = TextEditingController();

  final Connectivity _connectivity = Connectivity();
  String phone ="";
  bool isLoading = false;
  late SharedPreferences prefs;
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("Error Occurred: ${e.toString()} ");
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _UpdateConnectionState(result);
  }

  void showStatus(ConnectivityResult result, bool status) {
    final snackBar = SnackBar(
        content:
        Text("${status ? 'ONLINE\n' : 'OFFLINE\n'}${result.toString()} "),
        backgroundColor: status ? Colors.green : Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _UpdateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      setState(() {
        isLoading = false;
        //     showStatus(result, true);
      });
    } else {
      setState(() {
        //  showStatus(result, false);
        isLoading = true;
      });
    }
  }
  fetch() async {
    prefs = await SharedPreferences.getInstance();
    String translateshared = prefs.getString('StringTranslate') ?? "";
     phone = prefs.getString('phone') ?? "";
    print(phone);
  }
@override
void initState() {
  fetch();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      body: SizedBox(
        width: MySize.width(context),
        height: MySize.height(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MySize.height(context)/3),
              TextForm(hint: 'كلمه المرور'.tr(),controller: password,),
              TextForm(hint: "تاكيد كلمه المرور".tr(),controller: rePassword,),
              SizedBox(height: MySize.height(context)/10),
              ElevatedButton(onPressed: (){

                setState((){});
                  Controller.restPassword(context,
                  confiremPassword: rePassword.text,
                      password: password.text,phone:phone );
                  },
    child:const Text('تغيير كلمه المرور'))
            ],
          ),
        ),
      ),
    );
  }
}