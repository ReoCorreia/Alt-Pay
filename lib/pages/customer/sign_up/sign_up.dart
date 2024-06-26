import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/api_service/api_services.dart';
import 'package:flutter_application_1/pages/customer/login/sign_in.dart';
import 'package:flutter_application_1/pages/customer/sign_up/validate_phone.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';
import 'package:flutter_application_1/themes/text.dart';
import 'package:flutter_application_1/themes/text_field_decoration.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../themes/button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool incorrectPhone = false;
  String mobile = "";
  final ApiService apiService = ApiService();

  Future<void> _navigateToPhoneValidation() async {

    if(mobile.isEmpty){
      setState(() {
        incorrectPhone = true;
      });
      snackBarError(context, 'Phone Incorrect');
      return;
    }

  try {    
    Map<String, dynamic> responseData = await apiService.receiveOTP(mobile);
    print(responseData['data']['OTP']);
    String receivedOtp = responseData['data']['OTP'].toString();      
    Navigator.push(context, MaterialPageRoute(builder: (context) => ValidatePhone(mobile: mobile, receivedOtp: receivedOtp)));
  } catch (e) {
    snackBarError(context, '$e');
  }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Sign Up'),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Image.asset('lib/images/t-logo.png', width: 300, height: 300),
              Row(
                children: [                
                  Expanded(
                    child: IntlPhoneField(
                      initialCountryCode: 'GB',
                      disableLengthCheck: true,
                      decoration: decorate('Enter your phone'),
                      onChanged: (phone) {
                          setState(() {
                            mobile = phone.completeNumber;
                          });                        
                      },
                    ),
                  ),
                ],
              ).animate(target: incorrectPhone? 1 : 0).shakeX(hz: 14, curve: Curves.easeInOutCubic),
              const SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  const SizedBox(width: 5.0),
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      onPressed: () => _navigateToPhoneValidation(),
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
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()))
                      },
                      style: themeBtn2,
                      child: Text(
                        'Cancel',
                        style: themeTextField,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Column(
                children: [
                  const Text('Already a user?'),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn()))
                    },
                    child: const Text('Sign In', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue,decoration: TextDecoration.underline)),
                  )
                ],                  
              )
            ],
          ),
        ),
      ),
    );
  }
}