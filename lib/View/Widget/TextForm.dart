import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  String hint;
  Widget? widget;
  bool? visibility;
  TextEditingController? controller;
  TextInputType? keyBoardType;
  TextForm({
    Key? key,
    required this.hint,
    this.widget,
    this.visibility,
    this.keyBoardType,
     this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    height: 40,
        decoration: BoxDecoration(
            border: Border.all(width: 0),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade100),
        margin: const EdgeInsets.symmetric(vertical:12,horizontal: 20),
        padding: const EdgeInsets.symmetric( vertical:3,),
        child: TextField(
          keyboardType:keyBoardType ,
          obscureText: visibility ?? false,
          controller: controller??TextEditingController(),
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 12),
              border: InputBorder.none,
              icon: widget ?? const SizedBox()),
        ),
      );
}
