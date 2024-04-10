import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/sign_in.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/hint_style.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/text.dart';

class PasswordSetup extends StatefulWidget {

  final String name, phone;
  const PasswordSetup({super.key, required this.name, required this.phone});

  @override
  State<PasswordSetup> createState() => _PasswordSetupState();
}

class _PasswordSetupState extends State<PasswordSetup> {

  final TextEditingController _password = TextEditingController();
  final TextEditingController _cpassword = TextEditingController();

  void _submit(BuildContext context){
    if(_password.text.isEmpty || _cpassword.text.isEmpty){
      snackBarMessage('Please enter password and confirm password');
    }else if(_password.text != _cpassword.text){
      snackBarMessage('Both passwords must match');
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn()));
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

  Container textFieldContainer(hintText, TextEditingController controller){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0), // Apply border radius
        border: Border.all(color: themeBtnOrange), // Define border color and width
      ),              
      child: TextFormField(
        controller: controller,
        obscureText: true,
        keyboardType: TextInputType.text,
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
            textAlign: TextAlign.center,
            'Password Setup',
            style: themeTextField,
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            Text(
              'New Password',
              style: themeTextField2,
            ),
            TextField(
              controller: _password,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'New Password',
              ),
            ),
            const SizedBox(height: 30,),
            Text(
              'Confirm Password',
              style: themeTextField2,
            ),
            TextField(
              controller: _cpassword,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Confirm Password',
              ),
            ),
            const SizedBox(height: 20,),
            btnOrange(),
          ],
        ),
      ),      
    );
  }
}