import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';

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

  AppBar appBarTransactions(BuildContext context) {
    return AppBar(
      toolbarHeight: 180,
      centerTitle: true,
      backgroundColor: themeOrange,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          const Text(
            'Transactions',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle button press to select transactions by date
                  // You can navigate to another screen or show a date picker dialog
                },
                child: const Text('Select Date Range'),
              ),
            ],
          ),
        ],
      ),
    );
  }

