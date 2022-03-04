import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  String hint;
  Widget? widget;
  bool? visibility;
  TextEditingController controller;
  TextInputType? keyBoardType;
  TextForm({
    Key? key,
    required this.hint,
    this.widget,
    this.visibility,
    this.keyBoardType,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade300),
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          keyboardType:keyBoardType ,
          obscureText: visibility ?? false,
          controller: controller,
          decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              icon: widget ?? const SizedBox()),
        ),
      );
}
