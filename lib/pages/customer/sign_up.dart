import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/api_services.dart';
import 'package:flutter_application_1/pages/customer/validate_phone.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/text_field_decoration.dart';
import 'package:http/http.dart' as http;
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
  String mobile = "";
  final ApiService apiService = ApiService();

  Future<void> _navigateToPhoneValidation() async {

    if(mobile.isEmpty){
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

  try {
    http.Response response = await apiService.receiveOTP(mobile);

    if (response.statusCode == 200) {
      
      var responseData = jsonDecode(response.body);
      print(responseData['data']['OTP']);
      String receivedOtp = responseData['data']['OTP'].toString();      
      Navigator.push(context, MaterialPageRoute(builder: (context) => ValidatePhone(phone: mobile, receivedOtp: receivedOtp)));
    
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

}  

  void _navigateToHome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Sign Up'),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            Image.asset('lib/images/login.png', width: 300, height: 300),
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
                    onPressed: () => _navigateToHome(),
                    style: themeBtn2,
                    child: Text(
                      'Cancel',
                      style: themeTextField,
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
              ],
            )
          ],
        ),
      ),
    );
  }
}