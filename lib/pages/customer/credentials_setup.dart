import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/validate_credentials.dart';

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

  void _submit(BuildContext context){

    if(_ibanNo.text.isEmpty && _bankingRoutingNo.text.isEmpty){
      snackBarMessage('Please fill IBAN No or Banking Routing No');
      return;
    }else if(_accountNo.text.isEmpty){
      snackBarMessage('Please fill Account No');
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ValidateCredentials(name: widget.name ,phone: widget.phone, ibanNo: _ibanNo.text, bankingRoutingNo: _bankingRoutingNo.text, accountNo: _accountNo.text)));
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
            Text(
              'IBAN No:',
              style: themeTextField4,
            ),
            TextField(
              controller: _ibanNo,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Enter IBAN No',
              ),
            ),
            const SizedBox(height: 20,),

            Text(
              '( OR )',
              style: themeTextField4,
            ),
            const SizedBox(height: 20.0),            
            Text(
              'Banking Routing No:',
              style: themeTextField4,
            ),
            TextField(
              controller: _bankingRoutingNo,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Enter Banking Routing No',
              ),
            ),
            const SizedBox(height: 20.0),

            Text(
              'Account No:',
              style: themeTextField4,
            ),
            TextField(
              controller: _accountNo,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Enter Account No',
              ),
            ),
            const SizedBox(height: 20.0), 
            btnOrange(),
          ],
        ),
      ),      
    );
  }
}