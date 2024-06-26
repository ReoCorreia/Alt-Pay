import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_service/api_bank.dart';
import 'package:flutter_application_1/pages/customer/sign_up/validate_credentials.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:flutter_application_1/themes/text_field_decoration.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import '../../../themes/button.dart';
import '../../../themes/text.dart';

class CredentialSetup extends StatefulWidget {

  const CredentialSetup({super.key});

  @override
  State<CredentialSetup> createState() => _CredentialSetupState();
}

class _CredentialSetupState extends State<CredentialSetup> {

  final BankService bankService = BankService();
  final AuthManager authManager = AuthManager();
  final TextEditingController _ibanNo = TextEditingController();
  final TextEditingController _bankingRoutingNo = TextEditingController();
  final TextEditingController _accountNo = TextEditingController();

  Future<void> _submit() async {

    if(_ibanNo.text.isEmpty){
      if(_bankingRoutingNo.text.isEmpty || _accountNo.text.isEmpty){
        snackBarError(context, 'Please fill the required fields');
        return;        
      }
    }else if(_bankingRoutingNo.text.isEmpty || _accountNo.text.isEmpty){
      if(_ibanNo.text.isEmpty){
        snackBarError(context, 'Please fill the required fields');
        return;        
      }
    }

    Map<String, dynamic>? userData = await authManager.getAuthData();
    String mobile = userData?['mobile_number'];
    String name = userData?['user_name']; 
    await bankService.addBank(name, mobile, _bankingRoutingNo.text, _ibanNo.text.toUpperCase(), _accountNo.text, "bank");
    snackBarMessage(context, 'Bank details saved successfully');    
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ValidateCredentials(ibanNo: _ibanNo.text, bankingRoutingNo: _bankingRoutingNo.text, accountNo: _accountNo.text)));
  }

  ElevatedButton btnOrange(){
    ElevatedButton btn = ElevatedButton(
      style: themeBtn2,
      onPressed: () => _submit(),
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
      appBar: appBarAfterSignIn(context),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 30.0),
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