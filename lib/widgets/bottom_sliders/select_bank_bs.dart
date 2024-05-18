import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/color.dart';

class SelectBank extends StatefulWidget {
  const SelectBank({super.key});

  @override
  State<SelectBank> createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text('Hello')
      ],
    );
  }
}

void openTransactionBottomSheet(BuildContext context, Function(double, double) filterCallback) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: whitest,
    builder: (context) => const SelectBank(),
  );
}