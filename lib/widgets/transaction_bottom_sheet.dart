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
    return Row(
      children: [
        // NavigationRail starts here
        NavigationRail(
          leading: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Filter', style: bottomSheetHeading),
              ),
              Divider(
                color: textBlack,
              ),
            ],          
          ),
          backgroundColor: whitest,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          labelType: NavigationRailLabelType.selected,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.monetization_on),
              selectedIcon: Icon(Icons.monetization_on),
              label: Text('Filter'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.timeline),
              selectedIcon: Icon(Icons.sort),
              label: Text('Sort'),
            ),
          ],
        ),
        // Divider between navigation rail and content
        const VerticalDivider(thickness: 1, width: 1),
        // Content area
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: _selectedIndex == 0 
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: 
                    [
                      Text('Amount', style: bottomSheetHeading), ElevatedButton(onPressed: () =>{
                        widget.filterCallback(0,0)
                      }, style: themeBtn1, child: const Text('Clear'))
                    ],
                  )
                : Text('Type', style: bottomSheetHeading),
              ),
              Divider(
                color: textBlack,
              ),
              _selectedIndex == 0
                  ? RadioExample(filterCallback: widget.filterCallback)
                  : Text('Hello second', style: bottomSheetHeading),
            ],
          ),
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

class RadioExample extends StatefulWidget {
  final Function(double, double) filterCallback;
  const RadioExample({super.key, required this.filterCallback});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
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
