import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/homepagebussnise.dart';
import 'package:toordor/View/Widget/TextForm.dart';

class MyBusiness extends StatefulWidget {
  MyBusiness({Key? key}) : super(key: key);

  @override
  State<MyBusiness> createState() => _MyBusinessState();
}

class _MyBusinessState extends State<MyBusiness> {
  TextEditingController business = TextEditingController();

  String? trymenttype, lengthtrytype;
  Future? userservice;

  @override
  void initState() {
    userservice = Controller.fetchTreatsTypes(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Controller.fetchTreatsTypes(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder(
        future: Controller.myBuisness(context),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(

              itemCount: snapshot.data!['data'] ,
            );
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
