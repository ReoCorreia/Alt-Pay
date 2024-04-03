import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/sign_in.dart';

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
    print(_password.text == _cpassword.text);
    if(_password.text == _cpassword.text && _password.text.isNotEmpty && _cpassword.text.isNotEmpty){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn()));
    }
    else if(_password.text.isEmpty != _cpassword.text.isEmpty){
      showDialog(context: context, builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Passwords do not match'),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))
        ],
      ));
    }
    else{
      showDialog(context: context, builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Passwords cannot be empty'),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Credentials Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${widget.name}'),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: '${widget.phone}'),
              ),
            const SizedBox(height: 20.0),
            const Text('Password'),
            TextField(
              obscureText: true,
              controller: _password,
              ),
            const SizedBox(height: 20.0),
            const Text('Confirm Password'),
            TextField(
              obscureText: true,
              controller: _cpassword,
              ),
            const SizedBox(height: 20.0),
            ElevatedButton(onPressed: () => _submit(context), child: const Text('Submit')),                                                
          ],
        ),
      ),      
    );
  }
}