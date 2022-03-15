import 'package:flutter/material.dart';

class UserProFile extends StatelessWidget {
  const UserProFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: h / 20),
          ListTile(
            trailing: CircleAvatar(
              backgroundColor: Colors.indigo,
                child: Text('M'),
              radius: 100,
            ) ,
            // Container(
            //   alignment: Alignment.center,
            //   height: 210,
            //   width: 210,
            //   decoration: const BoxDecoration(
            //       shape: BoxShape.circle, color: Colors.indigo),
            //   child: const Text('M'),
            // ),
            title: const Text('اسم الشخص'),
            subtitle: const Text('ID:xxxxxxxxxxxx'),
            leading: const SizedBox(),
          ),
          SizedBox(height: h / 20),
          UserDataForm(
            title: 'الاسم بالكامل',
            userData: 'منار الكردي',
          ),
          UserDataForm(title: 'رقم الهاتف', userData: '0xxxxxxx'),
          UserDataForm(
            title: 'البريد الالكتروني',
            userData: 'xxxxxxx@xxxxxx.com',
          ),
          UserDataForm(
            title: 'المدينه',
            userData: 'القدس',
          ),
          UserDataForm(
            title: 'الدوله',
            userData: 'فلسطين',
          ),
          SizedBox(height: h / 15),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('حفظ')),
                ElevatedButton(onPressed: () {}, child: const Text('تعديل')),
                ElevatedButton(onPressed: () {}, child: const Text('الغاء')),
              ],
            ),
          )
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
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
            textAlign: TextAlign.start,
          ),
          SizedBox(width: w/15),
          Text(
            userData ?? '',
            style: const TextStyle(fontSize: 20),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.end,
          )
        ],
      ),
    );
  }
}
