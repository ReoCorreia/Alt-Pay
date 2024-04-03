import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/password_setup.dart';

class ValidateComplete extends StatefulWidget {

  final String name, phone;
  const ValidateComplete({super.key, required this.name, required this.phone});

  @override
  State<ValidateComplete> createState() => _ValidateCompleteState();
}

class _ValidateCompleteState extends State<ValidateComplete> {

  void _submit(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordSetup(name: widget.name ,phone: widget.phone)));
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
            Text('Dear ${widget.name}, Welcoe to Alt-Pay'),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: '${widget.phone}'),
              ),
            const SizedBox(height: 20.0),
            const Text('Partner: Monzo'),
            const SizedBox(height: 20.0),           
            const Text('IBAN No:'), 
            TextField(
              readOnly: true,
              controller: TextEditingController(text: 'AL47 2121 1009 0000 0002 3569 8741'),
              ),            
            const SizedBox(height: 20.0),            
            const Text('Your account has been successfully set-up. You can now use the app to make payments at any merchant location in any country where the Alt-Pay sign is displayed'),
            const SizedBox(height: 20.0),
            const Text('You can now set-up the Application Password to avoid having to use OTP to sign-on, going forward.'),
            const SizedBox(height: 20.0),
            ElevatedButton(onPressed: () => _submit(context), child: const Text('Setup Password')),
          ],
          ),
      ),      
    );
  }
}