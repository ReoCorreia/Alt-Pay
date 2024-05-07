import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/dashboard.dart';
import 'package:flutter_application_1/pages/customer/otp_sign_in.dart';
import 'package:flutter_application_1/pages/customer/sign_up.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';
import 'package:flutter_application_1/themes/text_field_decoration.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/hint_style.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_application_1/api_services.dart';

import 'forgot_password.dart';

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
      snackBarError(context, 'Phone field cannot be empty');
      return;
    }

    if (isOtpLogin) {
      try {
        http.Response response = await apiService.signInViaOTP(mobile);
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);
          String receivedOtp = responseData['data']['OTP'].toString();      
          Navigator.push(context, MaterialPageRoute(builder: (context) => OtpSignIn(mobile: mobile, receivedOtp: receivedOtp)));
        
        } else {
          snackBarError(context, 'Enter valid Phone Number');
        }
      } catch (e) {
        print('Error sending OTP: $e');
      }      
    } else {
      if (_password.text.isEmpty) {
        setState(() => incorrectPassword = true);
        snackBarError(context, 'Password cannot be empty');
        return;
      }
      // Implement password login functionality here
      try {
        await apiService.login(mobile, _password.text);
      } catch (e) {
        snackBarError(context, e.toString());
      }      
      await apiService.addDevice();
      snackBarMessage(context, 'Sign In Successfull');
      // Assuming login is successful
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Dashboard()), (route) => false);      
    }
  }

  Future<void> _signUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
  }

  Future<void> _forgotPassword() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Sign In'),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Column(
                children: [
                  Image.asset('lib/images/t-logo.png', width: 250, height: 250),
                  ToggleButtons(
                    isSelected: [!isOtpLogin, isOtpLogin],
                    fillColor: themeBtnOrange,
                    // color: Colors.black54,
                    selectedColor: Colors.white,
                    borderColor: Colors.grey,
                    selectedBorderColor: themeBtnOrange,
                    borderWidth: 1.0,
                    borderRadius: BorderRadius.circular(8),
                    renderBorder: true,
                    onPressed: (int index) {
                      setState(() {
                        isOtpLogin = index == 1;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Sign In via Password', style: toggleTextStyle),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Sign In via OTP', style: toggleTextStyle),
                      ),
                    ],                
                  ),
                ],
              ),
              const SizedBox(height: 40.0),            
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
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _submit(context),
                style: themeBtn2,
                child: Text(
                  isOtpLogin ? 'Send OTP' : 'Sign In',
                  style: themeTextField,
                ),
              ),
              const SizedBox(height: 10.0),
              isOtpLogin ? const SizedBox(
              ) : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Forgot Password? "),
                    GestureDetector(
                      onTap: () => _forgotPassword(),
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () => _signUp(),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
