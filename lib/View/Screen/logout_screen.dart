import 'package:flutter/material.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/Controller/size.dart';
import 'package:toordor/View/Screen/Home.dart';

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  void initState() {
    super.initState();
    Controller.logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(
              height: MySize.height(context) / 4, width: MySize.width(context)),
          const Text('هل انت متاكد من تسجيل الخروج',
              style: TextStyle(fontSize: 22)),
          SizedBox(height: MySize.height(context) / 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: MySize.width(context) / 4),
              ElevatedButton(
                  onPressed: () => Controller.logout(context),
                  child: const Text('نعم')),
              SizedBox(width: MySize.width(context) / 10),
              ElevatedButton(
                  onPressed: () => Controller.navigatorOff(context, Home()),
                  child: const Text('لا')),
              SizedBox(width: MySize.width(context) / 10),
            ],
          )
        ],
      )),
    );
  }
}
