import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_application_1/pages/customer/dashboard.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_application_1/themes/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/hint_style.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String _selectedCountryCode = "+91"; // Default country code
  bool incorrectPhone = false;
  bool incorrectPassword = false;
  
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _submit(BuildContext context){

    if(_phoneNumberController.text.isEmpty){
      setState(() {
        incorrectPhone = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            textAlign: TextAlign.center,
            'Phone Incorrect',
            style: themeTextField,            
          ).animate(target: incorrectPhone? 1 : 0).shakeX(hz: 14, curve: Curves.easeInOutCubic), 
          backgroundColor: themeBtnOrange
        ),
      );     
      return;
    }else if(_password.text.isEmpty){
      setState(() {
        incorrectPassword = true;
      });      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            textAlign: TextAlign.center,
            'Password Incorrect',
            style: GoogleFonts.getFont(
              'Lato',
              fontSize: 18,
              color: textWhite,
              fontWeight: FontWeight.bold,
              letterSpacing: .7,
            ),            
          ).animate(target: incorrectPassword? 1 : 0).shakeX(hz: 14, curve: Curves.easeInOutCubic), 
          backgroundColor: themeBtnOrange
        ),
      );
      return;
    }    
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
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
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: incorrectPhone? Colors.red : themeBtnOrange), // Define border color and width
                borderRadius: BorderRadius.circular(8.0), // Optionally, apply border radius
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CountryCodePicker(
                      onChanged: (CountryCode? code) {
                        setState(() {
                          _selectedCountryCode = code?.dialCode ?? _selectedCountryCode;
                        });
                      },
                      initialSelection: 'IN', // Initial selection country code
                      favorite: const ['+91'], // Your favorite country codes
                    ),
                  ),
                  // const SizedBox(width: 20.0),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Enter your phone number',
                        hintStyle: GoogleFonts.getFont(
                          'Lato',
                          fontWeight: FontWeight.w500,
                          letterSpacing: .7,
                        ),                        
                      ),
                    ),
                  ),
                ],
              ),
            ).animate(target: incorrectPhone? 1 : 0).shakeX(hz: 14, curve: Curves.easeInOutCubic),
            const SizedBox(height: 20.0),
            Row(
              children: [
                    // effects: [FadeEffect(), ScaleEffect()],
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0), // Apply border radius
                      border: Border.all(color: incorrectPassword? Colors.red : themeBtnOrange), // Define border color and width
                    ),

                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none, // Remove border around TextField
                        hintText: 'Enter your password',
                        hintStyle: GoogleFonts.getFont(
                          'Lato',
                          fontWeight: FontWeight.w500,
                          letterSpacing: .7,
                        ),                        
                        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      ),
                      controller: _password,
                    ),
                  ).animate(target: incorrectPassword? 1 : 0).shakeX(hz: 14, curve: Curves.easeInOutCubic),
                ),
              ],
            ),

            const SizedBox(height: 20.0),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () => _submit(context), 
                style: themeBtn2,
                child: Text(
                  'Sign In',
                  style: themeTextField,                
                ),
              ),
            ),
          ],
        ),

        ),
    );
  }
}