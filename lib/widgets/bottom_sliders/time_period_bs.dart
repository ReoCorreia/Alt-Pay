import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/text.dart';

class TimePeriod extends StatefulWidget {
  const TimePeriod({super.key});

  @override
  State<TimePeriod> createState() => _TimePeriodState();
}

class _TimePeriodState extends State<TimePeriod> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Select Time Period', style: bottomSheetHeading),
          ),
          InkWell(
            onTap: () => {
              setState(() {
                _value = 0;
              })
            },
            child: Container(
              height: 50,
              color:  _value == 0 ? lightGreen: null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Monthly', style: themeTextField4,),
                  )), 
                  _value == 0 ? const Expanded(child: Icon(Icons.check)) : const SizedBox(),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => {
              setState(() {
                _value = 1;
              })
            },            
            child: Container(
              height: 50,
              color:  _value == 1 ? lightGreen: null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Yearly', style: themeTextField4,),
                  )),
                  _value == 1 ? const Expanded(child: Icon(Icons.check)) : const SizedBox(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void openTimePeriodBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: whitest,
    builder: (context) => const TimePeriod(),
  );
}