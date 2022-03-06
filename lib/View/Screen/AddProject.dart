import 'package:flutter/material.dart';
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
          TextForm(hint: 'اسم المشروع', controller: projectName),
          TextForm(hint: 'رقم الهاتف', controller: phoneNumber),
          TextForm(hint: 'البريد الالكتروني', controller: email),
          TextForm(hint: 'التخصص', controller: specialty),
          StatefulBuilder(builder: (context, build) {
            return DropdownButton(
              hint: Text(title.isEmpty?'اختر دوله':title),
                items: countriesOfTheWorld
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (String? value) => build(() => title = value ?? ''));
          })
        ],
      ),
    );
  }
}
