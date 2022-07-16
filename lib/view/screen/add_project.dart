import 'package:csc_picker/csc_picker.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:toordor/controller/controller.dart';
import 'package:toordor/controller/size.dart';
import 'package:toordor/view/Widget/TextForm.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

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
  TimeOfDay? form;
  String fromText = '';
  TimeOfDay? to;
  String toText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Container(
                //   // child: const SizedBox(width: 300),
                //   height: 50,
                //   width: 150,
                //   decoration: const BoxDecoration(
                //     image: DecorationImage(
                //       fit: BoxFit.fitWidth,
                //       image: AssetImage(
                //           'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png'),
                //     ),
                //   ),
                // ),
                SizedBox(height: 20.sp),
                TextForm(hint: 'اسم المشروع', controller: projectName),
                TextForm(hint: 'رقم الهاتف', controller: phoneNumber),
                TextForm(hint: 'البريد الالكتروني', controller: email),
                TextForm(hint: 'التخصص', controller: specialty),
                const Text('اوقات العمل'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                        child: Text(fromText.isEmpty ? 'من' : fromText),
                        onPressed: () async => await showTimePicker(
                                context: context,
                                initialTime: form ?? TimeOfDay.now())
                            .then((value) => setState(() => fromText =
                                '${value?.hour ?? ''} : ${value?.minute}'))),
                    SizedBox(width: MySize.width(context) / 3),
                    FloatingActionButton(
                        child: Text(toText.isEmpty ? 'الي' : toText),
                        onPressed: () async => await showTimePicker(
                                context: context,
                                initialTime: to ?? TimeOfDay.now())
                            .then((value) => setState(() => toText =
                                '${value?.hour ?? ''} : ${value?.minute} '))),
                  ],
                ),
                Row(
                  children: [
                    form != null ? Text('$form') : const SizedBox(),
                    to != null ? Text('$to') : const SizedBox(),
                  ],
                ),
                SizedBox(height: MySize.height(context) / 20),
                CSCPicker(
                  defaultCountry: DefaultCountry.Palestinian_Territory_Occupied,
                  showStates: false,
                  //  onStateChanged: (String? myCity)=>setState(()=>city=myCity??''),
                  countryDropdownLabel:
                      country.isEmpty ? 'اختر دولتك' : country,
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
                          specialization: specialty.text,
                          fromt: fromText,
                          tot: toText);
                    },
                    // Controller.navigatorGo(context, MyBusiness());
                    child: const Text("حفظ"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
