import 'package:flutter/material.dart';
import 'package:toordor/view/widget/constant.dart';

class TextForm extends StatelessWidget {
  String hint;
  Widget? widget;
  bool? visibility;
  TextEditingController? controller;
  TextInputType? keyBoardType;
  ValueChanged<String>? onchange;
  IconButton ? icon;
  TextForm({
    Key? key,
    required this.hint,
    this.widget,
    this.visibility,
    this.keyBoardType,
    this.controller,
    this.onchange,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white),
        margin: const EdgeInsets.symmetric(vertical:12,horizontal: 20),
        padding: const EdgeInsets.symmetric( vertical:3,),
        child: TextFormField(
          keyboardType:keyBoardType ,
          obscureText: visibility ?? false,
          controller: controller??TextEditingController(),
          decoration: InputDecoration(
            suffixIcon: widget,
            contentPadding: EdgeInsets.only(right: 8,bottom: 10),
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorCustome.colorblue, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color:ColorCustome.colorblue, width: 2.0),
            ),
          ),

        ),
      );
}
