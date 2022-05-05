import 'package:flutter/material.dart';
import 'package:toordor/Controller/size.dart';
import 'package:toordor/View/Widget/TextForm.dart';

class MyEmployees extends StatelessWidget {
  const MyEmployees({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextForm(
                hint: 'البحث عن هويه',
                widget: IconButton(icon: Icon(Icons.search), onPressed: () {})),
            SizedBox(
                height: MySize.height(context) / 3,
                child: const Center(child: Text('نتائح البحث'))),
            Divider(height: 2),
            employCard(context, name: 'الموظف 1', id: "1"),
            employCard(context, name: 'الموظف 2', id: "2"),
            employCard(context, name: 'الموظف3', id: "3"),
            employCard(context, name: 'الموظف 4', id: "4"),
          ],
        ),
      ),
    );
  }
}

Widget employCard(BuildContext context,
        {required String name, required String id}) =>
    Container(
      margin: EdgeInsets.all(9),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(77)),
      width: MySize.width(context) / 1.2,
      height: MySize.height(context) / 5,
      child: Card(
        elevation: 19,
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [Text('الاسم: $name'), Text("رقم الهويه: $id")],
              ),
              ElevatedButton(onPressed: () {}, child: Text('مسح'))
            ],
          ),
        ),
      ),
    );
