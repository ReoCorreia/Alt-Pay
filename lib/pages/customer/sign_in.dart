import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/dashboard.dart';
import 'package:flutter_application_1/pages/customer/otp_sign_in.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/text_field_decoration.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/hint_style.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_application_1/api_services.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // for password login
  bool incorrectPhone = false;
  bool incorrectPassword = false;
  
  //for otp login
  bool isOtpLogin = false;  // Flag to check if user wants to login via OTP
  bool incorrectOTP = false;
  bool waiting = true;  
  
  String mobile = "";
  final AuthManager authManager = AuthManager();
  final ApiService apiService = ApiService();
  
  final TextEditingController _password = TextEditingController();  

  Future<void> _submit(BuildContext context) async {
    if (mobile.isEmpty) {
      setState(() => incorrectPhone = true);
      snackBarMessage('Phone field cannot be empty');
      return;
    }

    if (isOtpLogin) {
      try {
        http.Response response = await apiService.signInViaOTP(mobile);
        if (response.statusCode == 200) {
          
          var responseData = jsonDecode(response.body);
          print(responseData['data']['OTP']);
          String receivedOtp = responseData['data']['OTP'].toString();      
          Navigator.push(context, MaterialPageRoute(builder: (context) => OtpSignIn(mobile: mobile, receivedOtp: receivedOtp)));
        
        } else {
          
          print('Failed to send OTP. Status code: ${response.statusCode}');
          print('Error response: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                  textAlign: TextAlign.center,
                  'Enter valid Phone Number ',
                  style: themeTextField,
                ).animate(target: incorrectPhone? 1 : 0).shakeX(hz: 14, curve: Curves.easeInOutCubic),
                backgroundColor: themeBtnOrange
            ),
          );

        }
      } catch (e) {
        print('Error sending OTP: $e');
      }      
    } else {
      if (_password.text.isEmpty) {
        setState(() => incorrectPassword = true);
        snackBarMessage('Password cannot be empty');
        return;
      }
      // Implement password login functionality here
      await apiService.login(mobile, _password.text);      
      await apiService.addDevice();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const  Duration(seconds: 2),
          content: Text(
            textAlign: TextAlign.center,
            'Sign In Successfull',
            style: whiteSnackBar            
          ), 
          backgroundColor: textWhite
        ),
      );
      // Assuming login is successful
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Dashboard()), (route) => false);      
    }
  }

  void snackBarMessage(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error,
          textAlign: TextAlign.center,
          style: themeTextField,
        ).animate().shakeX(hz: 14, curve: Curves.easeInOutCubic),
        backgroundColor: themeBtnOrange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Sign In'),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            Image.asset('lib/images/login.png', width: 300, height: 300),
            ToggleButtons(
              isSelected: [!isOtpLogin, isOtpLogin],
              fillColor: themeBtnOrange,
              onPressed: (int index) {
                setState(() {
                  isOtpLogin = index == 1;
                });
              },
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Password', style: themeTextField),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('OTP', style: themeTextField),
                ),
              ],
            ),
            const SizedBox(height: 20.0),            
            IntlPhoneField(
              initialCountryCode: 'GB',
              disableLengthCheck: true,
              decoration: decorate('Enter your phone'),
              onChanged: (phone) {
                setState(() {
                  mobile = phone.completeNumber;
                });
              },
            ).animate(target: incorrectPhone ? 1 : 0).shakeX(hz: 14, curve: Curves.easeInOutCubic),
            const SizedBox(height: 20.0),
            isOtpLogin ? const SizedBox(
            ) : TextFormField(
              obscureText: true,
              decoration: decorate('Enter your password'),
              controller: _password,
            ),
            // const SizedBox(height: 20.0),
            // showOTPField && isOtpLogin ? OTPTextField(
            //   length: 4,
            //   width: MediaQuery.of(context).size.width,
            //   style: const TextStyle(
            //     fontSize: 17
            //   ),
            //   textFieldAlignment: MainAxisAlignment.spaceAround,
            //   fieldStyle: FieldStyle.underline,
              
            //   onCompleted: (pin) {setState(() { _otp = pin;});}
            // ) : const SizedBox(),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _submit(context),
              style: themeBtn2,
              child: Text(
                isOtpLogin ? 'Send OTP' : 'Sign In',
                style: themeTextField,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
