import 'package:flutter/material.dart';

import 'ImageButton.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(26)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HomeButton(image: 'assets/google.png', color: Colors.red),
            HomeButton(image: 'assets/facebook.png', color: Colors.blue),
            HomeButton(image: 'assets/instagram.png', color: Colors.pink)
          ],
        ),
      ),
    );
  }
}
// Stack(
// alignment: Alignment.center,
// children: [
// const Divider(thickness: 2),
// Container(
// padding: const EdgeInsets.all(9),
// color: Colors.white,
// child: const Text('تسجيل الدخول باسخدام',
// style: TextStyle(fontSize: 14)),
// ),
// ],
// ),
