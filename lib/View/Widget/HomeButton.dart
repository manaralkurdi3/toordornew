import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  VoidCallback? press;
  String? image;
  Color? color;

  HomeButton({Key? key,required this.image, this.press,this.color}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      color:color ,
        child: TextButton(onPressed: press??(){}, child: Image.asset(image??'',
        fit: BoxFit.fill,
        height: 30,
          width: 30,

        )));
  }
}
