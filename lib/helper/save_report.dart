import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> saveExcel(List<int> bytes) async {
  // Get the path to the documents directory.
  final Directory? directory = await getDownloadsDirectory();
  final String path = directory!.path;
  print(directory);
  const String fileName = '/storage/emulated/0/Documents/Output.xlsx';
  // Write the bytes to a file.
  final File file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);
  // Optionally, display a message to the user.
  print('Excel file saved at $fileName');
}

