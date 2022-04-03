import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/MyBusiness.dart';
import 'package:toordor/View/Widget/TextForm.dart';
import 'package:toordor/const/CountriesOfTheWorld.dart';

class AddProject extends StatelessWidget {
  AddProject({Key? key}) : super(key: key);
  TextEditingController projectName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController specialty = TextEditingController();
  String title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          SizedBox(height: 20.sp,),
          TextForm(hint: 'اسم المشروع', controller: projectName),
          TextForm(hint: 'رقم الهاتف', controller: phoneNumber),
          TextForm(hint: 'البريد الالكتروني', controller: email),
          TextForm(hint: 'التخصص', controller: specialty),
          StatefulBuilder(builder: (context, build) {
            return Container(
                padding: const EdgeInsets.only(left:12,right: 14),
              child: Row(
                children: [
                  DropdownButton(
                    hint: Text(title.isEmpty?'اختر دوله':title),
                      items: countriesOfTheWorld
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (String? value) => build(() => title = value ?? '')),
                ],
              ),
            );
          }),
          StatefulBuilder(builder: (context, build) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical:6,horizontal: 10),
           //   padding: const EdgeInsets.symmetric( vertical:3,),
              child: Row(
                children: [
                  DropdownButton(
                      hint: Text(title.isEmpty?'اختر العاصمة ':title),
                      items: countriesOfTheWorld
                          .map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ))
                          .toList(),
                      onChanged: (String? value) => build(() => title = value ?? '')),
                ],
              ),
            );
          }),
          ElevatedButton(onPressed:() {
          Controller.navigatorGo(context, MyBusiness());
          }, child: Text("حفظ"))
        ],
      ),
    );
  }
}
