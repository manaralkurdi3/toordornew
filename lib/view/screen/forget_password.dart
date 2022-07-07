import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toordor/View/Widget/TextForm.dart';
import 'package:toordor/const/components.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(35, 5, 20, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            defualtTextFormField(
              controller: email,
              type: TextInputType.emailAddress,
              prefix: Icons.email_outlined,
              label: 'Enter Your Email',
            ),
            // TextForm(hint: 'Enter Your Email', controller: email),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Send code'),
            ),
          ],
        ),
      ),
    );
  }
}
