import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/bottom_sheet.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:flutter_application_1/themes/text.dart';
import 'package:flutter_application_1/themes/text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';

final AuthManager authManager = AuthManager();

AppBar appBar(String title){
  return AppBar(  
    toolbarHeight: 80,
    centerTitle: false,
    automaticallyImplyLeading: false,
    backgroundColor: themeOrange,
    title: Padding(
      padding: const EdgeInsets.all(0.0),
      child: IconButton(
        onPressed: () => {},
        icon: Image.asset('lib/images/clipper-logo.png', height: 100, width: 100,),
      ),
    ),
  );
}

AppBar appBarAfterSignIn(BuildContext context){
  return AppBar(
    toolbarHeight: 80,
    centerTitle: false,
    backgroundColor: themeOrange,
    automaticallyImplyLeading: false,
    title: Padding(
      padding: const EdgeInsets.all(0.0),
      child: IconButton(
        onPressed: () => {},
        icon: Image.asset('lib/images/clipper-logo.png', height: 100, width: 100,),
      ),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.exit_to_app), // Sign out icon
        onPressed: () async {await authManager.signOut(context);}
      ),
    ],
  );
}

AppBar appBarDashboard(BuildContext context) {
  return AppBar(
    toolbarHeight: 180,
    centerTitle: false,
    backgroundColor: themeOrange,
    automaticallyImplyLeading: false,
    title: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('lib/images/clipper-logo.png', height: 100, width: 100,),
              IconButton(
                icon: const Icon(Icons.exit_to_app), // Sign out icon
                onPressed: () async {await authManager.signOut(context);}
              ),
            ],
          ),
          const Center(child: Text('Welcome to Alt-Pay', textAlign: TextAlign.center,)),
          const SizedBox(height: 8), // Add space between lines of text
          const Center(
            child: Text(
              'Our partner in United Kingdom is \nMonzo \nwww.monzo.com',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    ),
  );
}

AppBar appBarTransactions(BuildContext context, Function(double, double) filterCallback) {
  return AppBar(
    centerTitle: true,
    backgroundColor: themeOrange,
    automaticallyImplyLeading: false,
    title: Text(
          'Transactions',
          style: themeTextField5,
        ),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(80), // Adjust height as needed
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(onTap: ()=>{}, child: SvgPicture.asset('lib/images/less-than.svg', width: 30, height: 30,),),
            Text('May 2024', style: themeTextField,),
            GestureDetector(onTap: ()=>{}, child: SvgPicture.asset('lib/images/greater-than.svg', width: 30, height: 30,),),
          ],
        ),
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: GestureDetector(onTap: ()=>{
          transactionBottomSheet(context, filterCallback)
        }, child: SvgPicture.asset('lib/images/filter.svg', width: 35, height: 35,),),
      ),
    ],
  );
}


