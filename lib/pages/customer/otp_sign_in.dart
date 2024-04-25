import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_services.dart';
import 'package:flutter_application_1/pages/customer/dashboard.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpSignIn extends StatefulWidget {
  final String mobile, receivedOtp;
  
  const OtpSignIn({super.key, required this.mobile, required this.receivedOtp});

  @override
  State<OtpSignIn> createState() => OtpSignInState();
}

class OtpSignInState extends State<OtpSignIn> {
  String _otp = "";
  bool incorrectOTP = false;
  bool waiting = true;
  final ApiService apiService = ApiService();

  void _validatePhone() async{

    bool verified = await apiService.verifyLoginOTP(widget.mobile, _otp);

    if(verified){
      await apiService.addDevice();
      snackBarMessage(context, 'Sign In Successfull');      
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Dashboard()), (route) => false);
    }else if(!verified){
      setState(() {
        incorrectOTP = true;
      });
      snackBarError(context, 'OTP Incorrect');
      return;
    }
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

  Future<void> _resendOTP() async {
    if (!waiting) {
      try {
        http.Response response = await apiService.signInViaOTP(widget.mobile);
        setState(() {
          _otp = jsonDecode(response.body)['data']['OTP'].toString();
        });
        if (response.statusCode == 200) {
          snackBarMessage(context, 'Otp Sent');        
        } else {
          snackBarError(context, 'Failed to send OTP');                  
        }
      } catch (e) {
        print('Error sending OTP: $e');
      }      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('OTP Sign In'),

      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[

            Text("Enter otp: ${_otp.isEmpty ? widget.receivedOtp : _otp}"),

            const SizedBox(height: 30.0),

            const Center(
              child: Text(
                'Verification OTP',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                'OTP sent to ${maskPhoneNumber(widget.mobile)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Didn't receive the OTP? "),
                  GestureDetector(
                    onTap: () => !waiting? _resendOTP() : null,
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
                      setState(() {
                        waiting = false;
                      });
                    },
                  )
                ],
              ),
            ),

            const SizedBox(height: 30.0),
            OTPTextField(
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
            const SizedBox(height: 20.0),

            ElevatedButton(
              onPressed: _otp.length == 4? () => _validatePhone() : null,
              style: themeBtn2,
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      )
    );
  }
}