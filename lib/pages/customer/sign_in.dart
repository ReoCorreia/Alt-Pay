import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/dashboard.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/text_field_decoration.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/hint_style.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_application_1/api_services.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool incorrectPhone = false;
  bool incorrectPassword = false;
  String mobile = "";
  final AuthManager authManager = AuthManager();
  final ApiService apiService = ApiService();
  
  final TextEditingController _password = TextEditingController();  

  Future<void> _submit(BuildContext context) async{

    if(mobile.isEmpty){
      setState(() {
        incorrectPhone = true;
      });
      snackBarMessage('Phone field cannot be empty');     
      return;
    }else if(_password.text.isEmpty){
      setState(() {
        incorrectPassword = true;
      });      
      snackBarMessage('Password Incorrect');
      return;
    }else{      
      await apiService.login();
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

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Dashboard()),  (route) => false);
    }    
  }


  void snackBarMessage(String error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            textAlign: TextAlign.center,
            error,
            style: themeTextField,            
          ).animate().shakeX(hz: 14, curve: Curves.easeInOutCubic), 
          backgroundColor: themeBtnOrange
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
                  // const SizedBox(width: 20.0),
                ],
              ).animate(target: incorrectPhone? 1 : 0).shakeX(hz: 14, curve: Curves.easeInOutCubic),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    obscureText: true,
                    decoration: decorate('Enter your password'),
                    controller: _password,
                  ).animate(target: incorrectPassword? 1 : 0).shakeX(hz: 14, curve: Curves.easeInOutCubic),
                ),
              ],
            ),

            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _submit(context), 
              style: themeBtn2,
              child: Text(
                'Sign In',
                style: themeTextField,                
              ),
            ),
          ],
        ),
        ),
    );
  }
}

