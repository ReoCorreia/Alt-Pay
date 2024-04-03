import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_application_1/pages/customer/validate_phone.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String _selectedCountryCode = "+91"; // Default country code
  
  final TextEditingController _phoneNumberController = TextEditingController();

  void _navigateToPhoneValidation(BuildContext context, String phoneNumber) {
    // Navigate to customer page
    print('Phone: ${_phoneNumberController.text}');

    if(_phoneNumberController.text.length != 10){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid phone number')));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ValidatePhone(data: phoneNumber)),
    );
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Customer SignUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('lib/images/lankapay.png', width: 230, height: 250,),
            Row(
              children: [
                Expanded(
                  child: CountryCodePicker(
                    onChanged: (CountryCode? code) {
                      setState(() {
                        _selectedCountryCode = code?.dialCode ?? _selectedCountryCode;
                      });
                    },
                    initialSelection: 'IN', // Initial selection country code
                    favorite: const ['+91'], // Your favorite country codes
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Enter your phone number',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _navigateToPhoneValidation(context, _selectedCountryCode + _phoneNumberController.text),
                    child: const Text('Submit'),
                  ),                   
                ),
                const SizedBox(width: 25.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    child: const Text('Cancel'),
                  ),                   
                ),
              ],
            ),            
          ],
        ),
      ),
    );
  }
}