import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';

Future<void> saveExcel(BuildContext context, List<int> bytes, String outputFileName) async {
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

  if (selectedDirectory == null) {
    print('cancelled');
  }else{
    final String fileName = '$selectedDirectory/Output.xlsx';
    // Write the bytes to a file.
    final File file = File(fileName);
    try {
      await file.writeAsBytes(bytes, flush: true);
    } catch (e) {
      snackBarError(context, 'Error Saving File');  
    }
    snackBarMessage(context, 'File saved');
    // Optionally, display a message to the user.
    print('Excel file saved at $fileName');
  }  
}

