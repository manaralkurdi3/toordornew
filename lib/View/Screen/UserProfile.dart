import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/size.dart';
import 'package:toordor/Model/users.dart';
import 'package:toordor/View/Widget/TextForm.dart';

import '../../Controller/Controller.dart';

class UserProFile extends StatefulWidget {
  UserProFile({Key? key}) : super(key: key);

  @override
  State<UserProFile> createState() => _UserProFileState();
}

class _UserProFileState extends State<UserProFile> {
  String? fullName, phone, email, city, country;


  @override
  void initState() {
    Controller.userData(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: ()=>setState((){}),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
        await  Controller.userData(context);
        },
        child: FutureBuilder<dynamic>(
            future: Controller.userData(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var map = snapshot.data?['data'][0];
                fullName = map['fullName'];
                phone = map['phone1'];
                email = map['emailAdrs'];
                city = map['adrsCity'];
                country = map['usrCountry'];
                return Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 13.0.sp),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Text(fullName?[0] ?? ''),
                                  radius: 30.sp,
                                ),
                              ),
                              Text(
                                fullName ?? '',
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          SizedBox(height: MySize.height(context) / 20),
                          UserDataForm(
                              title: 'الاسم بالكامل', userData: fullName ?? ""),
                          UserDataForm(
                              title: 'رقم الهاتف', userData: phone ?? ''),
                          UserDataForm(
                              title: 'البريد الالكتروني', userData: email ?? ''),
                          UserDataForm(title: 'المدينه', userData: city ?? ''),
                          UserDataForm(title: 'الدوله', userData: country ?? ''),
                          SizedBox(height: MySize.height(context) / 20),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {}, child: const Text('حفظ')),
                                ElevatedButton(
                                    onPressed: () => Controller.navigatorGo(
                                        context,
                                        EditUserData(
                                            fullName: fullName,
                                            email: email,
                                            phone: phone,
                                            city: city,
                                            country: country)),
                                    child: const Text('تعديل')),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('الغاء'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

class UserDataForm extends StatelessWidget {
  UserDataForm({Key? key, this.title, this.userData}) : super(key: key);
  String? title;
  String? userData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title ?? '',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(width: 2.w),
          Text(
            userData ?? '',
            style: TextStyle(fontSize: 15.sp),
            // textDirection: TextDirection.rtl,
            //textAlign: TextAlign.end,
          )
        ],
      ),
    );
  }
}

class EditUserData extends StatelessWidget {
  EditUserData(
      {Key? key,
      this.fullName,
      this.phone,
      this.email,
      this.city,
      this.country})
      : super(key: key);
  final String? fullName, phone, email, city, country;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();

  addData() {
    controller1.text = fullName ?? '';
    controller2.text = phone ?? '';
    controller3.text = email ?? '';
    controller4.text = city ?? '';
    controller5.text = country ?? '';
  }

  @override
  Widget build(BuildContext context) {
    addData();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('تعديل البينات',
              style: TextStyle(color: Colors.white))),
      body: Column(
        children: [
          TextForm(hint: 'الاسم', controller: controller1),
          TextForm(hint: 'رقم الهاتف', controller: controller2),
          TextForm(hint: 'البريد الالكتروني', controller: controller3),
          TextForm(hint: 'المدينه', controller: controller4),
          TextForm(hint: 'الدوله', controller: controller5),
          ElevatedButton(
              onPressed: ()async =>
                  
              await  Controller.editUserData(context,
                  fullName: fullName,
                  phone: phone,
                  email: email,
                  city: city,
                  country: country).whenComplete(() => Controller.userData(context)),
              child:const Text('حفظ التعديلات'))
        ],
      ),
    );
  }
}
