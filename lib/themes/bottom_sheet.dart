import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/text_style.dart';

Future transactionBottomSheet(BuildContext context, Function(double, double) filterCallback){
  return showModalBottomSheet(
    context: context,
    // color is applied to main screen when modal bottom screen is displayed
    // barrierColor: Colors.greenAccent,
    //background color for modal bottom screen
    backgroundColor: whitest,
    //elevates modal bottom screen
    // elevation: 10,
    // gives rounded corner to modal bottom screen
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    builder: (BuildContext context) {
      // UDE : SizedBox instead of Container for whitespaces
      return SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Filter', style: themeTextFieldBlack),
              Divider(
                color: textBlack,
              ),
              Row(
                children: <Widget>[
                  const Column(
                    children: <Widget>[
                      Text('Type'),
                      Text('Amount'),
                    ],
                  ),
                  const VerticalDivider(
                    width: 20,
                    thickness: 4,
                    indent: 20,
                    endIndent: 0,
                    color: Colors.grey                                
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(onTap: () => {filterCallback(30000, 40000)}, child: const Text('filter'))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future selectBankBottomSheet(BuildContext context){
  return showModalBottomSheet(
    context: context,
    // color is applied to main screen when modal bottom screen is displayed
    // barrierColor: Colors.greenAccent,
    //background color for modal bottom screen
    backgroundColor: Colors.yellow,
    //elevates modal bottom screen
    elevation: 10,
    // gives rounded corner to modal bottom screen
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    builder: (BuildContext context) {
      // UDE : SizedBox instead of Container for whitespaces
      return const SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('data'),
            ],
          ),
        ),
      );
    },
  );
}

