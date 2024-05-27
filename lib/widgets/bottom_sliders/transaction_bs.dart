import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/text.dart';

class TransactionBottomSheet extends StatefulWidget {
  final Function(double, double) filterCallback;
  const TransactionBottomSheet({super.key, required this.filterCallback});

  @override
  State<TransactionBottomSheet> createState() => _TransactionBottomSheetState();
}

class _TransactionBottomSheetState extends State<TransactionBottomSheet> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[200],
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Filter', style: bottomSheetHeading),
              ],
            ),
          )
        ),
        Expanded(
          flex: 5,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        color: _selectedIndex == 0 ? grey : null,                        
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedIndex = 0;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: _selectedIndex == 0 ? MaterialStateProperty.all<Color>(grey) : MaterialStateProperty.all<Color>(Colors.transparent),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero, // Make it a rectangle
                                side: BorderSide.none, // No border
                              ),
                            ),
                            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent), // Remove tap color
                            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent), // Remove shadow
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.black), // Text color                          
                          ),
                          child: Text('Amount', style: filterByText,),
                        ),
                      ),
                    ],
                  ),
                )
              ),
              _selectedIndex == 0 
              ? Expanded(
                flex: 2, 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: () =>{
                      widget.filterCallback(0,0)
                      }, 
                      style: themeBtn1, child: const Text('Clear')
                    ),
                  ),
                  RadioFilter(filterCallback: widget.filterCallback),
                  ],
                )
              )
              : const Expanded(flex: 2, child: Text('type'))
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // Make it a rectangle
                          side: BorderSide(color: textBlack, width: 2), // No border
                        ),
                      ),
                      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent), // Remove tap color
                      shadowColor: MaterialStateProperty.all<Color>(Colors.transparent), // Remove shadow
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black), // Text color                          
                    ),
                    child: Text('Clear All', style: clearAll,),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // Make it a rectangle
                          side: BorderSide.none, // No border
                        ),
                      ),
                      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent), // Remove tap color
                      shadowColor: MaterialStateProperty.all<Color>(Colors.transparent), // Remove shadow
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black), // Text color                          
                    ),
                    child: Text('Apply', style: apply,),
                  ),
                ],
              ),
            ),
          )
        ),

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
    builder: (context) => TransactionBottomSheet(filterCallback: filterCallback),
  );
}

enum SingingCharacter {
  filter1,
  filter2,
  filter3,
  filter4,
  filter5
}

extension SingingCharacterExtension on SingingCharacter {
  String get label {
    switch (this) {
      case SingingCharacter.filter1:
        return '0-250';
      case SingingCharacter.filter2:
        return '250-1000';
      case SingingCharacter.filter3:
        return '1000-8000';        
      case SingingCharacter.filter4:
        return '8000-16000';
      case SingingCharacter.filter5:
        return '16000-40000';     
    }
  }

  RangeValues get range {
    switch (this) {
      case SingingCharacter.filter1:
        return const RangeValues(0, 250);
      case SingingCharacter.filter2:
        return const RangeValues(250, 1000);
      case SingingCharacter.filter3:
        return const RangeValues(1000, 8000);
      case SingingCharacter.filter4:
        return const RangeValues(8000, 16000);
      case SingingCharacter.filter5:
        return const RangeValues(16000, 40000);               
    }
  }
}

class RadioFilter extends StatefulWidget {
  final Function(double, double) filterCallback;
  const RadioFilter({super.key, required this.filterCallback});

  @override
  State<RadioFilter> createState() => _RadioFilter();
}

class _RadioFilter extends State<RadioFilter> {
  SingingCharacter? _character = SingingCharacter.filter1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (SingingCharacter character in SingingCharacter.values)
          ListTile(
            title: Text(character.label),
            trailing: Radio<SingingCharacter>(
              activeColor: grey,
              value: character,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });               
                widget.filterCallback(character.range.start, character.range.end);
              },
            ),
          ),
      ],
    );
  }
}
