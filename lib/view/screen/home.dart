import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/internet_connectin/internet_bloc.dart';
import 'package:toordor/view/widget/TextForm.dart';
import 'package:toordor/view/block/cubit/home_cubit.dart';
import 'package:toordor/view/block/state/home_state.dart';
import 'dart:ui' as ui;
import '../../controller/controller.dart';

class Home extends StatefulWidget {
  Widget body1;
   Home({Key? key,required this.body1}) : super(key: key);
  static  int indexPage = 0;


//String? token;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();

  // @override
  // void initState() {
  //
  //   super.initState();
  //   Controller.setPage (index: 0,setState: setState);
  // }
  late StreamSubscription subscription ;

  var isDeviceConected=false;

  bool isAlert = false;
  bool  isLoading =false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription < ConnectivityResult > _connectivitySubscription;
  // @override
  // void initState() {
  //   checkNetwork() ;
  //   super.initState();
  // }
  // @override
  // void dispose() {
  //   subscription.cancel();
  //   super.dispose();
  // }
  late SharedPreferences prefs;
  bool bussniseid=false;
  fetch() async {
    prefs = await SharedPreferences.getInstance();
    bussniseid = prefs.getBool('bussnisse_id') ?? false;
    print(bussniseid);
  }

  @override
  void initState() {
    String deviceLanguage= ui.window.locale.languageCode;
    print("deviceLanguage");
    //  print(deviceLanguage);
    fetch();
    //   _connectivity.onConnectivityChanged.listen(_UpdateConnectionState);
    super.initState();
  }

  @override
  void dispose() {
//  _connectivitySubscription.cancel();
    super.dispose();
  }
  Future< void > initConnectivity() async {
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

  Future<void> _UpdateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      isLoading=false;
      showStatus(result, true);
    } else {
      showStatus(result, false);
      isLoading=true;
    }
  }
  void showStatus(ConnectivityResult result, bool status) {
    final snackBar = SnackBar(
        content:
        Text("${status ? 'ONLINE\n' : 'OFFLINE\n'}${result.toString()} "),
        backgroundColor: status ? Colors.green : Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showDialogBox(){
    showCupertinoDialog(context: context, builder: (BuildContext context)=>
        CupertinoAlertDialog(
          title:Text("no connection internet ") ,
          content: Text("please on iternet "),
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    print(translator.activeLocale.toString());
    return
    FutureBuilder<dynamic>(
        future: Controller.userData(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("Has Busiesess  == ${snapshot.data?['message']['has_bussinees']}");
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                // leading: Container(
                //   child: const SizedBox(width: 300),
                //   height: 100,
                //   width: 150,
                //   decoration: const BoxDecoration(
                //     image: DecorationImage(
                //       fit: BoxFit.fitWidth,
                //       image: AssetImage(
                //           'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png'),
                //     ),
                //   ),
                // ),
                actions: [
                  snapshot.data?['message']['has_bussinees']==true
                      ?
                  PopupMenuButton(
                      itemBuilder: (context) => Controller.listpagebussnise
                          .map((e) => PopupMenuItem(
                          child: ListTile(trailing: Text(e.title)),
    onTap: ()
    {
    setState(()
    {
    Home.indexPage =
         Controller.listpagebussnise.indexOf(e);
    });

    }
                          // onTap: () {
                          //   setState((){
                          //
                          //     {Home.indexPage =
                          //         Controller.listpagebussnise.indexOf(e))
                          //
                          //
                          //
                          //     }
                          //   }

                            ),

                      )
                                .toList())
                                :
                            PopupMenuButton(
                            itemBuilder: (context) => Controller.list
                                .map((n) => PopupMenuItem(
                            child: ListTile(trailing: Text(n.title)),
                            onTap: () => setState(() => Home.indexPage =
                            Controller.list.indexOf(n))))
                                .toList())

                            ],
                            // title: TextForm(
                            //     hint: 'البحث',
                            //     onchange: (String? value) =>
                            //         Controller.query(context, query: value),
                            //     widget: IconButton(
                            //       icon: const Icon(Icons.search, color: Colors.blue),
                            //       onPressed: () {},
                            //     ),
                            //     keyBoardType: TextInputType.text)

                            ),
                            body: widget.body1

                );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
