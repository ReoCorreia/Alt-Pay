import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_application_1/pages/customer/dashboard.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String _selectedCountryCode = "+91"; // Default country code
  
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _submit(BuildContext context){
    print('Phone: ${_phoneNumberController.text}');
    print('Password: ${_password.text}');
    if(_phoneNumberController.text.isEmpty || _password.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Sign In'),
      ),      
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('lib/images/lankapay.png', width: 250, height: 230),
            const SizedBox(height: 20.0),
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
                const SizedBox(width: 20.0),
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
                const Expanded(child: Text('Password'),),
                Expanded(
                  flex: 2,
                  child: TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                    ),
                    controller: _password,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(onPressed: () => _submit(context), child: const Text('Sign In')),                                                    
          ],
        ),

        ),
    );
  }
}