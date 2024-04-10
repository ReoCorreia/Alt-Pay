import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/credentials_setup.dart';
import 'package:flutter_application_1/themes/button.dart';

import '../../themes/color.dart';
import '../../themes/hint_style.dart';

class IssuePartner extends StatefulWidget {

  final String name, phone;

  const IssuePartner({super.key, required this.name, required this.phone});

  @override
  State<IssuePartner> createState() => _IssuePartnerState();
}

class _IssuePartnerState extends State<IssuePartner> {

  void _credentialsPage(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CredentialSetup(name: widget.name ,phone: widget.phone)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: themeBtnOrange,
          title: Text(
            textAlign: TextAlign.center,
            'Issue Partner',
            style: themeTextField,
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            const Text(
              'Our partner in United Kingdom is \nMonzo \nwww.monzo.com',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ), 
            const SizedBox(height: 20.0),
            const Text(
              'Please know that we will be setting up and accessing your account credentials with them',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),                           
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(onPressed: () => _credentialsPage(context), style: themeBtn2 , child: const Text('OK & Continue')),
            const SizedBox(height: 20.0),
            const Text(
              'Let me check and revert to continue forward from here.',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}