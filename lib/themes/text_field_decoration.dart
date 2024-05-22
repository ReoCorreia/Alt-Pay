import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration decorate(String labelText){
  return InputDecoration(
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: lightGrey), borderRadius: BorderRadius.circular(8.0)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: lightGrey), borderRadius: BorderRadius.circular(8.0)),                
    labelText: labelText,
    labelStyle: GoogleFonts.getFont(
      'Lato',
      fontWeight: FontWeight.w500,
      letterSpacing: .7,
      color: themeBtnGrey,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),                  
  );
}