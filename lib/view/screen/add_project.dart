import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:csc_picker/csc_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'package:toordor/controller/controller.dart';
import 'package:toordor/controller/size.dart';
import 'package:toordor/model/category.dart';
import 'package:toordor/model/category_model.dart';
import 'package:toordor/view/Widget/TextForm.dart';
import 'package:toordor/view/screen/home_page.dart';
import 'package:toordor/view/screen/my_business.dart';
import 'package:toordor/view/screen/show_bussnise_appointment.dart';

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
  final _formKey = GlobalKey<FormState>();
  String category = '';
  Shared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool _hasbussnise = await SharedPreferences.getInstance()
        .then((value) => value.getBool('has_bussinees') ?? false);
    print(_hasbussnise);
  }
  final Connectivity _connectivity = Connectivity();
  bool isLoading = false;
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

  Controller controller = Controller();
  TimeOfDay? form;
  String  fromText="";
  TimeOfDay? to;
  String toText="";
  String services = "";
  String servicesEmployee = "";
  int idServices = 0;
  String serviceName = "";
  bool select=false;
  List category_ =[
    "صالون حلاقة رجالي".tr(),
    "صالونات تجميل".tr(),
    "تصميم اظافر".tr(),
    "تعليم القيادة".tr(),
    "غسيل سيارات".tr(),
    "مدرس خاص".tr(),
    "صالات رسم الوشم".tr(),
    "مدرب شخصي".tr(),
    "علاج واستشارة طبية".tr(),
    "تصوير".tr(),
    "مدرب حيوانات".tr(),
    "مدرب سباحة".tr(),
    "تدريب الفنون".tr(),
    "كراجات وتصليح".tr(),
    "مدقق حسابات".tr(),
    "محامين".tr(),
    "ميادين الرماية".tr(),
    "عرافة".tr(),
    "علاج طبيعي/ فيزوترابيا".tr(),
    "منتجع صحي وتدليك".tr(),
    "مستشار".tr(),
    "وسيط/وكيل".tr(),
    "طبيب بيطري".tr(),
    "مطاحن".tr(),
    "مجالس محلية".tr(),
    "معاصر الزيتون".tr(),
    "طبيب اسنان".tr(),
    "قاعات الافراح والمناسبات".tr(),
    "طبيب عيون".tr(),
    "طبيب  امراض البشرة".tr(),
    "كوافير نسائي".tr(),
  ];
  String formatTimeOfDay(TimeOfDay tod) {
    final dt = DateTime( tod.hour, tod.minute);
    final format = DateFormat.jm();
    //"6:00 AM"
    print(format);
    return format.format(dt);
  }
  List<String> weekdays = [
    "Friday".tr(),
    "Saturday".tr(),
    "Sunday".tr(),
    "Monday".tr(),
    "Thursday".tr(),
    "Wednesday".tr(),
    "Thuesday".tr()
  ];
  List<String> weekdays_selectuser = [];
  static TimeOfDay parseTimeOfDay(String t) {
    DateTime dateTime = DateFormat("HH:mm").parse(t);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }
  TimeOfDay? _selectedTime;

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timePicked != null)
      setState(() {
        _selectedTime = timePicked;
      });

    // Conversion logic starts here
    DateTime tempDate = DateFormat("h:m").parse(
        _selectedTime!.hour.toString() +
            ":" + _selectedTime!.minute.toString());
    var dateFormat = DateFormat("hh:mm"); // you can change the format here
    print(dateFormat.format(tempDate));
    fromText=dateFormat.format(tempDate);
    print(fromText);
   // print(tempDate);

  }
  @override
  Widget build(BuildContext context) {
    Shared();
    print("fromText");
print(fromText);
    return  Scaffold(
      appBar: AppBar2(context:context),
      body: SingleChildScrollView(
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
            Container(
              height: 50,
              width:300,
              child: FutureBuilder<List<CategoryModel>>(
                  future: Controller.categoryy(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount:category_.length,
                        itemBuilder: (context,index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 50,
                                width:500,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.grey[300]),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        hint: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              services.isEmpty ? "اختر فئة".tr() : services),
                                        ),
                                        items: snapshot.data!.map((CategoryModel value) {
                                          return DropdownMenuItem<String>(
                                            enabled: true,
                                            onTap: () {
                                              idServices = value.id??0;
                                              print(idServices);

                                            },
                                            value: category_[snapshot.data?.indexOf(value)??0]?? '',
                                            child: Text(
                                              category_[snapshot.data?.indexOf(value)??0]?? '',
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? val) {
                                          setState(() {
                                            services =val??'';
                                          //  showServiceEmployee = true;
                                          });
                                        }))),
                          );
                        }
                      );
                    } else {
                      print(snapshot.error);
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            SizedBox(height: 20.sp),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      child: TextForm(hint: 'اسم المشروع'.tr(),
                          controller: projectName)),
                  TextForm(hint: 'رقم الهاتف'.tr(), controller: phoneNumber),
                  TextForm(hint: 'البريد الالكتروني'.tr(), controller: email),
                  TextForm(hint: 'التخصص'.tr(), controller: specialty),
                ],
              ),
            ),

            Text("اختيار ايام العطلة".tr(),style: TextStyle(fontSize: 14),),
            Container(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: weekdays.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                print(weekdays[index]);
                                weekdays_selectuser.contains(
                                    weekdays[index]) ==
                                    true
                                    ?  weekdays_selectuser
                                    .remove(weekdays[index])
                                    : weekdays_selectuser
                                    .add(weekdays[index]);
                                print(weekdays_selectuser);
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 90,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                color: weekdays_selectuser
                                    .contains(
                                    weekdays[
                                    index]) ==
                                    true
                                    ? Colors.blue
                                    : Colors.white,
                              ),
                              child: Center(
                                  child: Text(
                                      weekdays[index])),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            ),
             Text('اوقات العمل'.tr()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  child: FloatingActionButton(
                    heroTag: "hero1",
                      child: Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(fromText.isEmpty ? 'من'.tr() : fromText),
                      )),
                      onPressed: () async {
                        _selectTime(context);
                      }),
                ),
                SizedBox(width: MySize.width(context) / 3),
                FloatingActionButton(
                    heroTag: "hero2",
                    child: Text(toText.isEmpty ? 'الى'.tr() : toText),
                    onPressed: () async => await showTimePicker(
                            context: context,
                            initialTime: to ?? TimeOfDay.now())
                        .then((value) => setState(() =>
                    toText =
                            '${value?.hour ?? 0}:${value?.minute??0} '))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  form != null ? Text('$fromText') : Text("من".tr()),
                  to != null ? Text('$toText') : Text("الى".tr()),
                ],
              ),
            ),
            SizedBox(height: MySize.height(context) / 80),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CSCPicker(
              //  defaultCountry: DefaultCountry.Palestinian_Territory_Occupied,
                showStates: false,
                dropdownHeadingStyle: TextStyle(fontSize: 10),
                //  onStateChanged: (String? myCity)=>setState(()=>city=myCity??''),
                countryDropdownLabel:
                    country.isEmpty ? 'اختر دولتك'.tr() : country,
                onCountryChanged: (value) => setState(() => country = value),
                //onStateChanged: (String? value)=>value!=null?city=value:null,
                showCities: false,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  print(fromText);
                  print(toText);
                  if (email.text.isEmpty||projectName.text.isEmpty||
                      phoneNumber.text.isEmpty||
                  fromText.isEmpty ||toText.isEmpty||weekdays.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                        content: Text(' الرجاء كتابة كافة المعلومات'.tr()),
                        backgroundColor: Colors.green,
                    ));
                  }
                else{
                    controller.insertBusiness(context,
                      city: "",
                      country: "",
                      email: email.text,
                      nameProject: projectName.text,
                      phoneNumber: phoneNumber.text,
                      specialization: specialty.text,
                      fromt: fromText,
                      id: idServices,
                      tot: toText,
                      weekend: weekdays_selectuser.toString(),)
                    ;
                    // ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                    //     content: Text(' تمت الاضافة بنجاح  '.tr())));
                   // Controller.navigatorGo(context, ShowBussniseAppointment());
                  }

                  //  Navigator.push(context, MaterialPageRoute(builder: ShowBussniseAppointment()));
                  //  Navigator.push(context, MaterialPageRoute(builder: MyBusiness()));
                },

                child:  Text("حفظ".tr()))
          ],
        ),
      ),
    );
  }
}
