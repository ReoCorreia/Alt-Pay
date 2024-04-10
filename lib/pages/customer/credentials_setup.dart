import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/password_setup.dart';
import 'package:flutter_application_1/pages/customer/validate_credentials.dart';
import 'package:flutter_application_1/themes/text.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/button.dart';
import '../../themes/color.dart';
import '../../themes/hint_style.dart';

class CredentialSetup extends StatefulWidget {

  final String name, phone;
  const CredentialSetup({super.key, required this.name, required this.phone});

  @override
  State<CredentialSetup> createState() => _CredentialSetupState();
}

class _CredentialSetupState extends State<CredentialSetup> {

  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _bankRoutingController = TextEditingController();
  final TextEditingController _accountNoController = TextEditingController();

  void _submit(BuildContext context){
    if(_ibanController.text.isEmpty && (_bankRoutingController.text.isEmpty && _accountNoController.text.isEmpty)){
      showSnackBarMessage('Fill all the necessary details to proceed further'); 
      return;     
    }
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Confirm Details"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("IBAN: ${_ibanController.text}"),
                Text("Bank Routing Number: ${_bankRoutingController.text}"),
                Text("Account Number: ${_accountNoController.text}"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel", style: dialogBoxBlackText,),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Confirm", style: dialogBoxOrangeText,),
              onPressed: () {
                // Close the dialog and proceed with the navigation
                Navigator.of(dialogContext).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => PasswordSetup(name: widget.name, phone: widget.phone),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void showSnackBarMessage(String text){
    ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                textAlign: TextAlign.center,
                text,
                style: GoogleFonts.getFont(
                  'Lato',
                  fontSize: 18,
                  color: textWhite,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .7,
                ),            
              ).animate().shakeX(hz: 14, curve: Curves.easeInOutCubic), 
              backgroundColor: themeBtnOrange
            ),
          );    
  }

  Container textFieldContainer(hintText, TextEditingController controller){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0), // Apply border radius
        border: Border.all(color: themeBtnOrange), // Define border color and width
      ),              
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: GoogleFonts.getFont(
            'Lato',
            fontWeight: FontWeight.w500,
            letterSpacing: .7,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),                  
        ),
      ),
    );
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
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20.0),                            
            textFieldContainer('IBAN No', _ibanController),
            const SizedBox(height: 20.0),
            const Text('( OR )'),        
            const SizedBox(height: 20.0),            
            textFieldContainer('Banking Routing No', _bankRoutingController),
            const SizedBox(height: 20.0),
            textFieldContainer('Account No', _accountNoController),
            const SizedBox(height: 20.0), 
            ElevatedButton(onPressed: () => _submit(context), style: themeBtn2, child: const Text('Submit')),                                   
          ],
        ),
      ),
    );
  }
}