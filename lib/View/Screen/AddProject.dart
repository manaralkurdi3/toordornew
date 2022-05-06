import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Widget/TextForm.dart';
import 'package:toordor/const/CountriesOfTheWorld.dart';

class AddProject extends StatelessWidget {
  AddProject({Key? key}) : super(key: key);
  TextEditingController projectName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController specialty = TextEditingController();
  String city = '';

  String country="";
Controller controller = Controller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Wrap(
        children: [
          Column(
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
                            hint: Text(city.isEmpty?'اختر دوله':city),
                              items: countriesOfTheWorld
                                  .map((e) => DropdownMenuItem(
                                        child: Text(e),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (String? value) => build(() => city = value ?? '')),
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
                          hint: Text(country.isEmpty?'اختر العاصمة ':country),
                          items: countriesOfTheWorld
                              .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                              .toList(),
                          onChanged: (String? value) => build(() => country = value ?? '')),
                    ],
                  ),
                );
              }),
              ElevatedButton(onPressed:() {
                controller.insertBusiness(context,city:city,country: country,email:email.text,nameProject: projectName.text,phoneNumber: phoneNumber.text,specilization:specialty.text   );
             // Controller.navigatorGo(context, MyBusiness());
              }, child: const Text("حفظ"))
            ],
          ),
        ],
      ),
    );
  }
}
