import 'package:flutter/material.dart';
import 'package:toordor/View/Widget/TextForm.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: const SizedBox(width: 300,),
          height: 70,
          width: 300,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png',
              )
            )
          ),
        ),
        title: TextForm(hint: 'Search', controller: search,widget: IconButton(
          icon: const Icon(Icons.search),
          onPressed: (){},
        ),keyBoardType: TextInputType.text,),

      ),
    );
  }
}
