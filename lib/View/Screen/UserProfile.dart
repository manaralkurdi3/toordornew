import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class UserProFile extends StatelessWidget {
  const UserProFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder<SharedPreferences>(
                    future: SharedPreferences.getInstance(),
                    builder: (context, d) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 13.0.sp),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Text(d.data?.getString('name')?[0] ?? ''),
                              radius: 30.sp,
                            ),
                          ),
                          Text(
                            d.data!.getString('name') ?? '',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      );
                    }),
                SizedBox(height: h / 20),
                UserDataForm(title: 'الاسم بالكامل', userData: "مرحبا ${snapshot.data!.getString('uName')}"),
                UserDataForm(title: 'رقم الهاتف', userData: '0xxxxxxx'),
                UserDataForm(
                    title: 'البريد الالكتروني', userData: 'manaralkurdi'),
                UserDataForm(title: 'المدينه', userData: 'القدس'),
                UserDataForm(title: 'الدوله', userData: 'فلسطين'),
                SizedBox(height: h / 15),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {}, child: const Text('حفظ')),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('تعديل')),
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
    double w = MediaQuery.of(context).size.width;
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
            style: TextStyle(fontSize: 16.sp),
            // textDirection: TextDirection.rtl,
            //textAlign: TextAlign.end,
          )
        ],
      ),
    );
  }
}
