import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/sign_in.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/hint_style.dart';
import 'package:flutter_application_1/themes/text_field_decoration.dart';

class PasswordSetup extends StatefulWidget {

  final String name, phone;
  const PasswordSetup({super.key, required this.name, required this.phone});

  @override
  State<PasswordSetup> createState() => _PasswordSetupState();
}

class _PasswordSetupState extends State<PasswordSetup> {

  final TextEditingController _password = TextEditingController();
  final TextEditingController _cpassword = TextEditingController();

  void _submit(BuildContext context){
    if(_password.text.isEmpty || _cpassword.text.isEmpty){
      snackBarMessage('Please enter password and confirm password');
    }else if(_password.text != _cpassword.text){
      snackBarMessage('Both passwords must match');
    }else{
      snackBarMessageNormal('Sign Up Successful, redirecting to Login...');
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignIn()),
        );
      });
    }
  }

  void snackBarMessage(error){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            textAlign: TextAlign.center,
            '$error',
            style: themeTextFieldError,
          ).animate().shakeX(hz: 14, curve: Curves.easeInOutCubic),
          backgroundColor: themeBtnOrange
      ),
    );
  }

  void snackBarMessageNormal(String error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            textAlign: TextAlign.center,
            error,
            style: themeTextField,            
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: themeBtnOrange
        ),
      );    
  }  

  TextFormField textFieldContainer(hintText, TextEditingController controller){
    return TextFormField(
      controller: controller,
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: decorate(hintText)
    );
  }

  ElevatedButton btnOrange(){
    return ElevatedButton(
      style: themeBtn2,
      onPressed: () => _submit(context),
      child: Text(
        'Submit',
        style: themeTextField,
      ),
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
            'Password Setup',
            style: themeTextField,
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            textFieldContainer('New Password', _password),
            const SizedBox(height: 30,),
            textFieldContainer('Confirm Password', _cpassword),
            const SizedBox(height: 20,),
            btnOrange(),
          ],
        ),
      ),      
    );
  }
}