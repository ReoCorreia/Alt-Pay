import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_service/api_services.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/text.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_application_1/pages/customer/enter_name.dart';
import '../../themes/button.dart';

class ValidatePhone extends StatefulWidget {
  final String mobile, receivedOtp;
  
  const ValidatePhone({super.key, required this.mobile, required this.receivedOtp});

  @override
  State<ValidatePhone> createState() => _ValidatePhoneState();
}

class _ValidatePhoneState extends State<ValidatePhone> {
  String _otp = "";
  bool incorrectOTP = false;
  bool waiting = true;
  final ApiService apiService = ApiService();

  void _validatePhone() async{
    try {
      bool verified = await apiService.verifySignUpOTP(widget.mobile, _otp);
      if(verified){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EnterName(data: widget.mobile)));
      }else if(!verified){
        setState(() {
          incorrectOTP = true;
        });
        snackBarError(context, 'OTP Incorrect');
        return;
      }
    } catch (e) {
      print('Exception occurred: $e');
      snackBarError(context, 'Some error occured');
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
    if (waiting) {
      print('waiting');
    }else{
      print('OTP resent');

      try {    
        Map<String, dynamic> responseData = await apiService.receiveOTP(widget.mobile);
        print(responseData['data']['OTP']);
        String receivedOtp = responseData['data']['OTP'].toString();      
        Navigator.push(context, MaterialPageRoute(builder: (context) => ValidatePhone(mobile: widget.mobile, receivedOtp: receivedOtp)));
      } catch (e) {
        print('Error sending OTP: $e');
        snackBarError(context, '$e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Validate Phone Number'),

      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: ListView(
            children: <Widget>[

              const SizedBox(height: 30.0),
          
              Center(
                child: Text(
                  'Verification OTP',
                  style: themeTextFieldBlack
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
                child: Text('Verify OTP', style: themeTextField,),
              ),
            ],
          ),
        ),
      )
    );
  }
}