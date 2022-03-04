import 'package:flutter/material.dart';
import 'package:toordor/View/Widget/TextForm.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextForm(hint: 'Enter Your Email', controller: email),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: const Text('Send code'))
        ],
      ),
    );
  }
}
