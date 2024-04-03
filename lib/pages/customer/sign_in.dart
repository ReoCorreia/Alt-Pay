import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_application_1/pages/customer/dashboard.dart';

import 'package:flutter_application_1/styles/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/styles/color.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all  fields')));
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeBtnOrange,
        title: const Text('Sign In'),
      ),      
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            Image.asset('lib/images/login.png', width: 300, height: 300),
            // const SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: themeBtnOrange), // Define border color and width
                borderRadius: BorderRadius.circular(8.0), // Optionally, apply border radius
              ),
              child: Row(
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
                  // const SizedBox(width: 20.0),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Enter your phone number',
                      ),                    
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0), // Apply border radius
                      border: Border.all(color: themeBtnOrange), // Define border color and width
                    ),
                    child: TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none, // Remove border around TextField
                        hintText: 'Enter your password',
                        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      ),
                      controller: _password,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Divider(
                    color: themeBtnOrange,
                  )
                ),
                const SizedBox(width: 5.0),         
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => _submit(context), 
                    style: themeBtn2,
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.getFont(
                        'Lato',
                        fontSize: 18,
                        color: textWhite,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .7,
                      ),                
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),                
                Expanded(
                  child: Divider(
                    color: themeBtnOrange,
                  )
                )                                
              ],
            )
          ],
        ),

        ),
    );
  }
}