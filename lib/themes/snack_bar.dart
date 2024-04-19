import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/hint_style.dart';

void snackBarError(BuildContext context, String error){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        textAlign: TextAlign.center,
        error,
        style: themeTextField,            
      ).animate().shakeX(hz: 14, curve: Curves.easeInOutCubic), 
      backgroundColor: themeBtnOrange
    ),
  );    
}


void snackBarMessage(BuildContext context, String error){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          textAlign: TextAlign.center,
          error,
          style: themeTextField,            
        ),
        backgroundColor: themeBtnOrange
      ),
    );    
}