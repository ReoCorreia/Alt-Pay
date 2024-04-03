import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles/color.dart';

final ButtonStyle customerPrimary = ElevatedButton.styleFrom(
  minimumSize: const Size(327, 50),
  backgroundColor: orange,
  foregroundColor: Colors.white,
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),    
  )
);

final ButtonStyle merchantPrimary = ElevatedButton.styleFrom(
  minimumSize: const Size(327, 50),
  backgroundColor: purple,  
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),    
  )
);