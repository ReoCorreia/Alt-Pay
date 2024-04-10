import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/validate_phone.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/button.dart';
import '../../themes/color.dart';
import '../../themes/hint_style.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String _selectedCountryCode = "+91"; // Default country code
  bool incorrectPhone = false;

  final TextEditingController _phoneNumberController = TextEditingController();

  void _navigateToPhoneValidation(BuildContext context, String phoneNumber) {

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
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ValidatePhone(phone: phoneNumber)),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
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
            'Sign Up',
            style: themeTextField,
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            // target: incorrectInput? 1 : 0 can be used inside animate() to conditionally animate.
            Image.asset('lib/images/login.png', width: 300, height: 300),
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
                      initialSelection: 'United Kingdom', // Initial selection country code
                      favorite: const ['+44'], // Your favorite country codes
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
              children: <Widget>[
                const SizedBox(width: 5.0),
                Expanded(
                  flex: 4,
                  child: ElevatedButton(
                    onPressed: () => _navigateToPhoneValidation(context, _selectedCountryCode + _phoneNumberController.text),
                    style: themeBtn2,
                    child: Text(
                      'Send OTP',
                      style: themeTextField,
                    ),
                  ),
                ),

                const SizedBox(width: 20.0),
                Expanded(
                  flex: 4,
                  child: ElevatedButton(
                    onPressed: () => _navigateToHome(context),
                    style: themeBtn2,
                    child: Text(
                      'Cancel',
                      style: themeTextField,
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                // Expanded(
                //     child: Divider(
                //       color: themeBtnOrange,
                //     )
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}