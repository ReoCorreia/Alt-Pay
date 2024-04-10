import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/hint_style.dart';

AppBar appBar(String title){
  return AppBar(
    centerTitle: true,
    backgroundColor: themeBtnOrange,
    title: Text(
    title,
    style: themeTextField,
    ),
  );
}