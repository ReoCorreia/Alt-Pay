import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/color.dart';

final ButtonStyle themeBtn1 = ElevatedButton.styleFrom(
  backgroundColor: themeBtnGrey,
  foregroundColor: Colors.white,
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),
  )
);

final ButtonStyle themeBtn2 = ElevatedButton.styleFrom(
  backgroundColor: themeBtnOrange,
  foregroundColor: Colors.white,
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),    
  )
);

final ButtonStyle datePicker = ElevatedButton.styleFrom(
  backgroundColor: lightGrey,
  foregroundColor: black,
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  )
);

final ButtonStyle excelButton = ElevatedButton.styleFrom(
  backgroundColor: green,
  foregroundColor: whitest,
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  )
);

final ButtonStyle lightGreyBtn = ElevatedButton.styleFrom(
  backgroundColor: lightGrey,
  foregroundColor: whitest,
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  )
);