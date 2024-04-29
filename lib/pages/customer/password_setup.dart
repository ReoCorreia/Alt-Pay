import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_services.dart';
import 'package:flutter_application_1/pages/customer/sign_in.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/hint_style.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';
import 'package:flutter_application_1/themes/text_field_decoration.dart';

class PasswordSetup extends StatefulWidget {

  final String name, phone;
  const PasswordSetup({super.key, required this.name, required this.phone});

  @override
  State<PasswordSetup> createState() => _PasswordSetupState();
}

class _PasswordSetupState extends State<PasswordSetup> {

  final ApiService apiService = ApiService();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cpassword = TextEditingController();

  Future<void> _submit(BuildContext context) async{
    if(_password.text.isEmpty || _cpassword.text.isEmpty){
      snackBarError(context, 'Please enter password and confirm password');
    }else if(_password.text != _cpassword.text){
      snackBarError(context, 'Both passwords must match');
    }else{

      try {
        await apiService.setPassword(widget.phone, _password.text);
        snackBarMessage(context, 'Sign Up Successful, redirecting to Login...');
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignIn()));
        });
      } catch (e) {
        snackBarError(context, 'Error Saving User details: $e');
      }
      
    }
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
      appBar: appBar('Password Setup'),
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