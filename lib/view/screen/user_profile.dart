import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/size.dart';
import 'package:toordor/View/Widget/TextForm.dart';

import '../../Controller/controller.dart';
import '../block/cubit/home_cubit.dart';
import '../block/state/home_state.dart';

class UserProFile extends StatefulWidget {
  UserProFile({Key? key}) : super(key: key);

  @override
  State<UserProFile> createState() => _UserProFileState();
}

class _UserProFileState extends State<UserProFile> {
  @override
  void initState() {
    Controller.userData(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await Controller.userData(context);
            },
            child: FutureBuilder<dynamic>(
                future: Controller.userData(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
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
                                      child: const Text(""),
                                      radius: 30.sp,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?['message']['fullname'] ?? "",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              SizedBox(height: MySize.height(context) / 20),
                              UserDataForm(
                                title: 'الاسم بالكامل',
                                userData:
                                    snapshot.data?['message']['fullname'] ?? "",
                              ),
                              UserDataForm(
                                title: 'رقم الهاتف',
                                userData:
                                    snapshot.data?['message']['phone'] ?? "",
                              ),
                              UserDataForm(
                                  title: 'اسم المسنخدم',
                                  userData: snapshot.data?['message']
                                      ['username']),
                              UserDataForm(
                                title: 'المدينه',
                                userData: cubit.address ?? "",
                              ),
                              UserDataForm(
                                title: 'الدوله',
                                userData: cubit.address ?? "",
                              ),
                              SizedBox(height: MySize.height(context) / 20),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('حفظ')),
                                    ElevatedButton(
                                        onPressed: () => Controller.navigatorGo(
                                            context,
                                            EditUserData(
                                              fullName: snapshot
                                                  .data?['message']['fullname'],
                                              phone: snapshot.data?['message']
                                                  ['phone'],
                                              email: snapshot.data?['message']
                                                  ['username'],
                                              country: snapshot.data?['message']
                                                  ['country_id'],
                                              city: snapshot.data?['message']
                                                  ['city_id'],
                                            )),
                                        child: const Text('تعديل')),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
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
      },
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
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(width: 2.w),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              userData ?? '',
              style: TextStyle(fontSize: 13.sp),
              // textDirection: TextDirection.rtl,
              //textAlign: TextAlign.end,
            ),
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
            title: const Text('تعديل البيانات',
                style: TextStyle(color: Colors.white))),
        body: SingleChildScrollView(
          child: Column(children: [
            TextForm(hint: 'الاسم', controller: controller1),
            TextForm(hint: 'رقم الهاتف', controller: controller2),
            TextForm(hint: 'البريد الالكتروني', controller: controller3),
            TextForm(hint: 'المدينه', controller: controller4),
            TextForm(hint: 'الدوله', controller: controller5),
            ElevatedButton(
              child: Text("حفظ التعديلات "),
              onPressed: () => Controller.userDataEdit(
                context,
                phone: controller2,
                city: controller4,
                country: controller5,
                name: controller3,
                fulname: controller1,
              ),
            ),
          ]),
        ));
  }
}
