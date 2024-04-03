import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_application_1/pages/customer/enter_name.dart';

class ValidatePhone extends StatefulWidget {
  final String data; // Variable to hold the passed string
  
  const ValidatePhone({super.key, required this.data});

  @override
  State<ValidatePhone> createState() => _ValidatePhoneState();
}

class _ValidatePhoneState extends State<ValidatePhone> {
  String _otp = "";

  void  _validatePhone(){
    print("OTP: $_otp");

    if(_otp.length != 4){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid OTP')));
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EnterName(data: widget.data)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Validate Phone Number'),
      ),   
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter OTP',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              ),
            Text(
              'OTP sent to ${widget.data}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
              ),
            const SizedBox(height: 20.0),  
            Flexible(
              child: OTPTextField(
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
              ),
            const SizedBox(height: 20.0),
            ElevatedButton(onPressed: () => _validatePhone(), child: const Text('Verify Phone')),
          ],
        ),
      ),         
    );
  }
}