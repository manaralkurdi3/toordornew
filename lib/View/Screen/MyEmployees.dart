import 'package:flutter/material.dart';
import 'package:toordor/View/Widget/TextForm.dart';


class MyEmployees extends StatelessWidget {
  const MyEmployees({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextForm(hint: 'البحث عن هويه',widget: IconButton(icon: Icon(Icons.search),onPressed: (){}),),
          Row(
            children: [
              ElevatedButton(onPressed: (){}, child: Text(''))
            ],
          )
        ],
      ),
    );
  }
}
