import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_application_1/pages/customer/enter_name.dart';

import '../../themes/button.dart';
import '../../themes/text.dart';
import '../../themes/color.dart';
import '../../themes/hint_style.dart';

class ValidatePhone extends StatefulWidget {
  final String phone; // Variable to hold the passed string
  
  const ValidatePhone({super.key, required this.phone});

  @override
  State<ValidatePhone> createState() => _ValidatePhoneState();
}

class _ValidatePhoneState extends State<ValidatePhone> {

  String _otp = "";
  bool incorrectOTP = false;
  bool waiting = true;

  get incorrectPhone => null;

  void  _validatePhone(){

    if(_otp.length != 4){
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid OTP')));
      // return;
      print('Resend OTP');
      setState(() {
        incorrectOTP = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              textAlign: TextAlign.center,
              'OTP Incorrect',
              style: GoogleFonts.getFont(
                'Lato',
                fontSize: 18,
                color: textWhite,
                fontWeight: FontWeight.bold,
                letterSpacing: .7,
              ),
            ).animate(target: incorrectOTP ? 1 : 0).shakeX(hz: 14, curve: Curves.easeInOutCubic),
            backgroundColor: themeBtnOrange
        ),
      );
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EnterName(data: widget.phone)));
  }

  String maskPhoneNumber(String phoneNumber) {
    // Extracting the country code
    String countryCode = phoneNumber.substring(0, 3);

    // Extracting the last 4 digits of the phone number
    String lastFourDigits = phoneNumber.substring(phoneNumber.length - 4);

    // Creating the masked phone number
    String maskedPhoneNumber = '$countryCode ******$lastFourDigits';

    return maskedPhoneNumber;
  }

  void _resendOTP(){
    // Resend OTP logic here
    if (waiting) {
      print('waiting');
    }else{
      print('Resend OTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: themeBtnOrange,
        title: Text(
          textAlign: TextAlign.center,
          'Validate Phone  Number',
          style: themeTextField,
        )
      ),

      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[

            const SizedBox(height: 30.0),

            Center(
              child: Text(
                'Verification OTP',
                style: themeTextField1,
              ),
            ),
            Center(
              child: Text(
                'OTP sent to ${maskPhoneNumber(widget.phone)}',
                style: themeTextField2,
              ),
            ),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Didn't receive the OTP? "),
                  GestureDetector(
                    onTap: () => _resendOTP(),
                    child: const Text(
                      'Resend OTP',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Text("  "),
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 30, end: 0),
                    duration: const Duration(seconds: 30),
                    builder: (context, value, child) => Text(
                      '00:${value.toInt()}',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onEnd: () {
                      // Add your logic here
                      waiting = false;
                    },
                  )
                ],
              ),
            ),

            const SizedBox(height: 30.0),
            Flexible(
              child: OTPTextField(
                length: 4,
                width: MediaQuery.of(context).size.width,
                style: const TextStyle(
                  fontSize: 17
                ),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  setState(() {
                    _otp = pin;
                  });
                },
              ),
            ),
            const SizedBox(height: 20.0),

            ElevatedButton(
              onPressed: () => _validatePhone(),
              style: themeBtn2,
              child: const Text('Verify Phone'),
            ),
          ],
        ),
      )
    );
  }
}
