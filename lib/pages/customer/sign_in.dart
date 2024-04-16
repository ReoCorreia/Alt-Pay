import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/dashboard.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/text_field_decoration.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/hint_style.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool incorrectPhone = false;
  bool incorrectPassword = false;
  
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _submit(BuildContext context){

    if(_phoneNumberController.text.isEmpty){
      setState(() {
        incorrectPhone = true;
      });
      snackBarMessage('Phone Incorrect');     
      return;
    }else if(_password.text.isEmpty){
      setState(() {
        incorrectPassword = true;
      });      
      snackBarMessage('Password Incorrect');
      return;
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            textAlign: TextAlign.center,
            'Sign In Successful',
            style: whiteSnackBar            
          ), 
          backgroundColor: textWhite
        ),
      );      
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
    }    
  }

  void snackBarMessage(String error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            textAlign: TextAlign.center,
            error,
            style: themeTextField,            
          ).animate().shakeX(hz: 14, curve: Curves.easeInOutCubic), 
          backgroundColor: themeBtnOrange
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
            'Sign In',
            style: themeTextField,            
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            // target: incorrectInput? 1 : 0 can be used inside animate() to conditionally animate.
            Image.asset('lib/images/login.png', width: 300, height: 300),
            // const SizedBox(height: 20.0),
            Row(
                children: [
                  Expanded(
                    child: IntlPhoneField(
                      initialCountryCode: 'GB',
                      decoration: decorate('Enter your phone'),
                      controller: _phoneNumberController,
                    ),
                  ),
                  // const SizedBox(width: 20.0),
                ],
              ).animate(target: incorrectPhone? 1 : 0).shakeX(hz: 14, curve: Curves.easeInOutCubic),
            const SizedBox(height: 20.0),
            Row(
              children: [
                    // effects: [FadeEffect(), ScaleEffect()],
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    obscureText: true,
                    decoration: decorate('Enter your password'),
                    controller: _password,
                  ).animate(target: incorrectPassword? 1 : 0).shakeX(hz: 14, curve: Curves.easeInOutCubic),
                ),
              ],
            ),

            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _submit(context), 
              style: themeBtn2,
              child: Text(
                'Sign In',
                style: themeTextField,                
              ),
            ),
          ],
        ),
        ),
    );
  }
}