import 'package:flutter/material.dart';

const primaryColor = Color(0xff2bbcee);
const secondColor = Color(0xffdf831f);
const whiteColor = Color(0xfffcfcfc);


class Pages {
  String title;
  IconData icon;
  Widget  page;
  Pages({required this.title, required this.icon,required this.page});
}
