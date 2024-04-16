import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/validate_phone.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/themes/text_field_decoration.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../themes/button.dart';
import '../../themes/color.dart';
import '../../themes/hint_style.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool incorrectPhone = false;

  final TextEditingController _phoneNumberController = TextEditingController();

  void _navigateToPhoneValidation(BuildContext context) {

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
      MaterialPageRoute(builder: (context) => ValidatePhone(phone: _phoneNumberController.text)),
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
              children: <Widget>[
                const SizedBox(width: 5.0),
                Expanded(
                  flex: 4,
                  child: ElevatedButton(
                    onPressed: () => _navigateToPhoneValidation(context),
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