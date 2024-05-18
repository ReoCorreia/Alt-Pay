import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/text_style.dart';

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
    Color? _amountColor = _selectedIndex == 0 ? grey : null;
    Color? _typeColor = _selectedIndex == 1 ? grey : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[200],
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Filter', style: bottomSheetHeading),
              ],
            ),
          )
        ),
        Expanded(
          flex: 8,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(onTap: () => {
                        setState(() {
                          _selectedIndex = 0;
                        })
                      }, child: Container(height: 40, width: double.infinity, color: _amountColor, child: Center(child: Text('Amount'))),),
                      GestureDetector(onTap: () => {
                        setState(() {
                          _selectedIndex = 1;
                        })
                      }, child: Container(height: 40, width: double.infinity, color: _typeColor, child: Center(child: Text('Type'))),),                  
                    ],
                  ),
                )
              ),
              _selectedIndex == 0 
              ? Expanded(
                flex: 4, 
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
              : Expanded(flex: 4, child: Text('type'))
            ],
          ),
        ),
      ],
    );

    // return Row(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.all(14.0),
    //       child: _selectedIndex == 0 
    //       ? Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: 
    //           [
    //             Text('Amount', style: bottomSheetHeading), ElevatedButton(onPressed: () =>{
    //               widget.filterCallback(0,0)
    //             }, style: themeBtn1, child: const Text('Clear'))
    //           ],
    //         )
    //       : Text('Type', style: bottomSheetHeading),
    //     ),
    //     Divider(
    //       color: textBlack,
    //     ),
    //     // NavigationRail starts here
    //     NavigationRail(
    //       leading: Column(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Text('Filter', style: bottomSheetHeading),
    //           ),
    //           Divider(
    //             color: textBlack,
    //           ),
    //         ],          
    //       ),
    //       backgroundColor: whitest,
    //       selectedIndex: _selectedIndex,
    //       onDestinationSelected: (int index) {
    //         setState(() {
    //           _selectedIndex = index;
    //         });
    //       },
    //       labelType: NavigationRailLabelType.selected,
    //       destinations: const [
    //         NavigationRailDestination(
    //           icon: Icon(Icons.monetization_on),
    //           selectedIcon: Icon(Icons.monetization_on),
    //           label: Text('Filter'),
    //         ),
    //         NavigationRailDestination(
    //           icon: Icon(Icons.timeline),
    //           selectedIcon: Icon(Icons.sort),
    //           label: Text('Sort'),
    //         ),
    //       ],
    //     ),
    //     // Divider between navigation rail and content
    //     const VerticalDivider(thickness: 1, width: 1),
    //     // Content area
    //     Expanded(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           _selectedIndex == 0
    //               ? RadioFilter(filterCallback: widget.filterCallback)
    //               : Text('Hello second', style: bottomSheetHeading),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
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
        return '0-100';
      case SingingCharacter.filter2:
        return '100-200';
      case SingingCharacter.filter3:
        return '250-1000';        
      case SingingCharacter.filter4:
        return '1000-2000';
      case SingingCharacter.filter5:
        return '30000-40000';     
    }
  }

  RangeValues get range {
    switch (this) {
      case SingingCharacter.filter1:
        return const RangeValues(0, 100);
      case SingingCharacter.filter2:
        return const RangeValues(100, 200);
      case SingingCharacter.filter3:
        return const RangeValues(200, 1000);
      case SingingCharacter.filter4:
        return const RangeValues(1000, 2000);
      case SingingCharacter.filter5:
        return const RangeValues(30000, 40000);               
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
            leading: Radio<SingingCharacter>(
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
