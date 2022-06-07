import 'package:csc_picker/csc_picker.dart';
import 'package:csc_picker/model/select_status_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/Controller/size.dart';
import 'package:toordor/View/Widget/TextForm.dart';
import 'package:toordor/const/CountriesOfTheWorld.dart';

class AddProject extends StatefulWidget {
  AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  TextEditingController projectName = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController specialty = TextEditingController();

  String city = '';

  String country = "";

  String category = '';

  Controller controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        children: [
          Column(
            children: [
              SizedBox(height: 20.sp),
              TextForm(hint: 'اسم المشروع', controller: projectName),
              TextForm(hint: 'رقم الهاتف', controller: phoneNumber),
              TextForm(hint: 'البريد الالكتروني', controller: email),
              TextForm(hint: 'التخصص', controller: specialty),
              // StatefulBuilder(builder: (context, update) {
              //   return DropdownButton(
              //       hint: Text(category.isEmpty ? 'اختر القسم' : category),
              //       items: Controller.category
              //           .map((e) => DropdownMenuItem(child: Text(e), value: e))
              //           .toList(),
              //       onChanged: (String? value) {
              //         if (value != null) {
              //           update(() => category = value);
              //         }
              //       });
              // }),
              SizedBox(height: MySize.height(context) / 20),
              CSCPicker(
                defaultCountry: DefaultCountry.Palestinian_Territory_Occupied,
                showStates: false,
                //  onStateChanged: (String? myCity)=>setState(()=>city=myCity??''),
                countryDropdownLabel: country.isEmpty ? 'اختر دولتك' : country,
                onCountryChanged: (value) => setState(() => country = value),
                //onStateChanged: (String? value)=>value!=null?city=value:null,
                showCities: false,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.insertBusiness(context,
                        city: city,
                        country: country,
                        email: email.text,
                        setState: setState,
                        nameProject: projectName.text,
                        phoneNumber: phoneNumber.text,
                        specilization: specialty.text);
                    // Controller.navigatorGo(context, MyBusiness());
                  },
                  child: const Text("حفظ"))
            ],
          ),
        ],
      ),
    );
  }
}
