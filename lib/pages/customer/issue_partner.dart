import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/password_setup.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import '../../themes/button.dart';

class IssuePartner extends StatefulWidget {

  final String name, phone;

  const IssuePartner({super.key, required this.name, required this.phone});

  @override
  State<IssuePartner> createState() => _IssuePartnerState();
}

class _IssuePartnerState extends State<IssuePartner> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Issue Partner'),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            Text(
              'Dear ${widget.name}, Welcome to Alt-Pay',
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Phone ${widget.phone}',
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Our partner in United Kingdom is \nMonzo \nwww.monzo.com',
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Please know that we will be setting up and accessing your account credentials with them',
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordSetup(name: widget.name ,phone: widget.phone)))},
                style: themeBtn2,
                child: const Text('OK & Continue')
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Let me check and revert to continue forward from here.',
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}