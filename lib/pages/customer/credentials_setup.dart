import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/validate_credentials.dart';
import 'package:flutter_application_1/themes/text_field_decoration.dart';
import 'package:flutter_application_1/variables/api_variables.dart';
import 'package:http/http.dart' as http;

import '../../themes/button.dart';
import '../../themes/color.dart';
import '../../themes/hint_style.dart';
import '../../themes/text.dart';

class CredentialSetup extends StatefulWidget {

  final String name, phone;

  const CredentialSetup({super.key, required this.name, required this.phone});

  @override
  State<CredentialSetup> createState() => _CredentialSetupState();
}

class _CredentialSetupState extends State<CredentialSetup> {

  final TextEditingController _ibanNo = TextEditingController();
  final TextEditingController _bankingRoutingNo = TextEditingController();
  final TextEditingController _accountNo = TextEditingController();

  Future<void> _submit(BuildContext context) async {

    if(_ibanNo.text.isEmpty && _bankingRoutingNo.text.isEmpty){
      snackBarMessage('Please fill IBAN No or Banking Routing No');
      return;
    }else if(_accountNo.text.isEmpty){
      snackBarMessage('Please fill Account No');
      return;
    }

    Map<String, dynamic> response = await addBank(widget.name, widget.phone, _bankingRoutingNo.text, _ibanNo.text, _accountNo.text, "bank");
    print(response["error"]);
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ValidateCredentials(name: widget.name ,phone: widget.phone, ibanNo: _ibanNo.text, bankingRoutingNo: _bankingRoutingNo.text, accountNo: _accountNo.text)));
  }

  Future<Map<String, dynamic>> addBank(String name, String phone, String bankingRoutingNo, String iban, String accountNo, String bank) async{
      var response = await http.post(
        Uri.parse('http://$apiDomain/users/v1/add_bank'),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'gAAAAABmIN1LP2Hz8XWjtlQGnZpNlxCWfkybWuRKvgA0xmt-DRVhi_z6IS-qPIO3Bw7q44fR0XL8aiUCvagHSJgaCoYyi987UjGhtsbp3jLpNtO7PHwbot9HrI6UhUbf9Hg1GuZmjSmx-PTrmkRT85F9NtrcpjXNfQ=='
        },
        body: jsonEncode(<String, String>{
          "mobile": phone,
          "iban": iban,
          "bank_routing_number": bankingRoutingNo,
          "account_number": accountNo,
          "bank": bank
        }),
      );
      // Parse the response JSON string
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      
      // Check if the request was successful (error is false)
      if (!jsonResponse['error']) {
        // Return the response as a map
        return jsonResponse;
      } else {
        // If there was an error, throw an exception with the error message
        snackBarMessage(jsonResponse["message"]);
        throw Exception('Failed to add bank: ${jsonResponse['message']}');
      }    
  }

  void snackBarMessage(error){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            textAlign: TextAlign.center,
            '$error',
            style: themeTextFieldError,
          ).animate().shakeX(hz: 14, curve: Curves.easeInOutCubic),
          backgroundColor: themeBtnOrange
      ),
    );
  }

  ElevatedButton btnOrange(){
    ElevatedButton btn = ElevatedButton(
      style: themeBtn2,
      onPressed: () => _submit(context),
      child: Text(
        'Submit',
        style: themeTextField,
      ),
    );
    return btn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: themeBtnOrange,
        title: Text(
          'Credentials Setup',
          style: themeTextField,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            Text(
              'Partner: Monzo',
              style: themeTextField2,
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _ibanNo,
              keyboardType: TextInputType.text,
              decoration: decorate('Enter IBAN No')
            ),
            const SizedBox(height: 20,),

            Text(
              '( OR )',
              style: themeTextField4,
            ),
            const SizedBox(height: 20.0),            
            TextField(
              controller: _bankingRoutingNo,
              keyboardType: TextInputType.number,
              decoration: decorate('Enter Banking Routing No')
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _accountNo,
              keyboardType: TextInputType.number,
              decoration: decorate('Enter Account No')
            ),
            const SizedBox(height: 20.0), 
            btnOrange(),
          ],
        ),
      ),      
    );
  }
}