import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/sign_in.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/hint_style.dart';
import 'package:google_fonts/google_fonts.dart';

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
      showSnackBarMessage('Please enter both fields');
    }else if(_password.text != _cpassword.text){
      showSnackBarMessage('Both passwords must match');
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn()));
    }
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
            const SizedBox(height: 20.0),
            textFieldContainer('New Password', _password),
            const SizedBox(height: 20.0),
            textFieldContainer('Confirm Password', _cpassword),
            const SizedBox(height: 20.0),
            ElevatedButton(onPressed: () => _submit(context), style: themeBtn2, child: const Text('Submit')),                                                
          ],
        ),
      ),      
    );
  }
}