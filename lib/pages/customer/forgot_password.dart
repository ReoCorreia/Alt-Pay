import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/themes/text.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../api_service/api_services.dart';
import '../../themes/app_bar.dart';
import '../../themes/button.dart';
import '../../themes/text_field_decoration.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final ApiService apiService = ApiService();
  // ignore: unused_field
  final TextEditingController _password = TextEditingController();
  bool incorrectPhone = false;
  String mobile = "";

  Future<void> _submit(BuildContext context) async{

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
      appBar: appBar('Forgot Password'),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
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
            btnOrange(),
          ],
        ),
      ),
    );
  }
}