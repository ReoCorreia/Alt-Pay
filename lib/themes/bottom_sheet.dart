import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/text.dart';

Future transactionBottomSheet(BuildContext context, Function(double, double) filterCallback) {
  return showModalBottomSheet(
    backgroundColor: whitest,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    builder: (BuildContext context) {
      int selectedIndex = 0;
      return Row(
        children: [
          // NavigationRail starts here
          NavigationRail(
            backgroundColor: whitest,
            selectedIndex: 0,
            onDestinationSelected: (int index) {
              selectedIndex = index;
            },
            labelType: NavigationRailLabelType.selected,
            destinations: const[
              NavigationRailDestination(
                icon: Icon(Icons.filter_alt),
                selectedIcon: Icon(Icons.filter_alt),
                label: Text('Filter'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.sort),
                selectedIcon: Icon(Icons.sort),
                label: Text('Sort'),
              ),
              // Add more destinations as needed
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
                  child: Text('Filter', style: bottomSheetHeading),
                ),
                Divider(
                  color: textBlack,
                ),
                selectedIndex == 0 ? Text('Hello first', style: bottomSheetHeading) : Text('Hello second', style: bottomSheetHeading),
              ],
            ),
          ),
        ],
      );
    },
  );
}

// GestureDetector(onTap: () => {filterCallback(30000, 40000)}, child: const Text('filter'))

// Future selectBankBottomSheet(BuildContext context){
//   return showModalBottomSheet(
//     context: context,
//     // color is applied to main screen when modal bottom screen is displayed
//     // barrierColor: Colors.greenAccent,
//     //background color for modal bottom screen
//     backgroundColor: Colors.yellow,
//     //elevates modal bottom screen
//     elevation: 10,
//     // gives rounded corner to modal bottom screen
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(12.0),
//     ),
//     builder: (BuildContext context) {
//       // UDE : SizedBox instead of Container for whitespaces
//       return const SizedBox(
//         height: 200,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text('data'),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

