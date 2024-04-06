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

            const SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Expanded(
                    child: Divider(
                      color: themeBtnOrange,
                    )
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => _submit(context),
                    style: themeBtn2,
                    child: Text(
                      'Send OTP',
                      style: themeTextField,
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => _submit(context),
                    style: themeBtn2,
                    child: Text(
                      'Cancel',
                      style: themeTextField,
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                    child: Divider(
                      color: themeBtnOrange,
                    )
                )
              ],
            )
          ],
        ),

      ),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/customer_home.dart';
import 'package:flutter_application_1/pages/customer/validate_phone.dart';
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

    // if(_phoneNumberController.text.length != 10){
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid phone number')));
    //   return;
    // }

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
      MaterialPageRoute(builder: (context) => ValidatePhone(data: phoneNumber)),
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
            'Customer SignUp',
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

            const SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Expanded(
                    child: Divider(
                      color: themeBtnOrange,
                    )
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => _navigateToPhoneValidation(context, _selectedCountryCode + _phoneNumberController.text),
                    style: themeBtn2,
                    child: Text(
                      'Sign In',
                      style: themeTextField,
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                    child: Divider(
                      color: themeBtnOrange,
                    )
                )
              ],
            )
          ],
        ),

      ),


      // body: Padding(
      //   padding: const EdgeInsets.all(25.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: <Widget>[
      //       Image.asset('lib/images/lankapay.png', width: 230, height: 250,),
      //       Row(
      //         children: [
      //           Expanded(
      //             child: CountryCodePicker(
      //               onChanged: (CountryCode? code) {
      //                 setState(() {
      //                   _selectedCountryCode = code?.dialCode ?? _selectedCountryCode;
      //                 });
      //               },
      //               initialSelection: 'IN', // Initial selection country code
      //               favorite: const ['+91'], // Your favorite country codes
      //             ),
      //           ),
      //           const SizedBox(width: 15.0),
      //           Expanded(
      //             flex: 2,
      //             child: TextFormField(
      //               controller: _phoneNumberController,
      //               keyboardType: TextInputType.phone,
      //               decoration: const InputDecoration(
      //                 hintText: 'Enter your phone number',
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //       const SizedBox(height: 20.0),
      //       Row(
      //         children: [
      //           Expanded(
      //             child: ElevatedButton(
      //               onPressed: () => _navigateToPhoneValidation(context, _selectedCountryCode + _phoneNumberController.text),
      //               child: const Text('Submit'),
      //             ),
      //           ),
      //           const SizedBox(width: 25.0),
      //           Expanded(
      //             child: ElevatedButton(
      //               onPressed: () {
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) => const CustomerHome()),
      //                 );
      //               },
      //               child: const Text('Cancel'),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}