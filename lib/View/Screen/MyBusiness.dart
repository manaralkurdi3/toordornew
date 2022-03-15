import 'package:flutter/material.dart';
import 'package:toordor/View/Widget/TextForm.dart';

class MyBusiness extends StatelessWidget {
  MyBusiness({Key? key}) : super(key: key);
  TextEditingController business = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: h,
      width: w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: h / 20),
          const ListTile(
            trailing: CircleAvatar(
              backgroundColor: Colors.indigo,
              child: Text('M'),
              radius: 100,
            ),

            // Container(
            //   alignment: Alignment.center,
            //   height: 210,
            //   width: 210,
            //   decoration: const BoxDecoration(
            //       shape: BoxShape.circle, color: Colors.indigo),
            //   child: const Text('A'),
            // ),
            title: Text('اسم المشروع'),
            subtitle: Text('ID:xxxxxxxxxxxx'),
            leading: SizedBox(),
          ),
          SizedBox(height: h / 10),
          TextForm(hint: 'نوع الخدمه', controller: business),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Text(
                'وقت الخدمه:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              title: Text('x الي x'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Text(
                'اضف خدمه جديده',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              title: TextButton(
                onPressed: () {},
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle),
                    height: 40,
                    width: 40,
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                    )),
              ),
            ),
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
