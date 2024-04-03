import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/validate_complete.dart';

class ValidateCredentials extends StatefulWidget {

  final String name, phone;
  const ValidateCredentials({super.key, required this.name, required this.phone});

  @override
  State<ValidateCredentials> createState() => _ValidateCredentialsState();
}

class _ValidateCredentialsState extends State<ValidateCredentials> {

  void _validate(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ValidateComplete(name: widget.name ,phone: widget.phone)));
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
            Text('Dear ${widget.name}, Welcome to Alt-Pay'),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: '${widget.phone}'),
              ),
            const SizedBox(height: 20.0),
            const Text('Partner: Monzo'),
            const SizedBox(height: 20.0),           
            const Text('IBAN No: \nAL47 2121 1009 0000 0002 3569 8741'), 
            const SizedBox(height: 20.0),            
            const Text('You will now be redirected to our partner website/app for validation of your credentials'),
            const SizedBox(height: 20.0),
            ElevatedButton(onPressed: () => _validate(context), child: const Text('Submit')),
          ],
          ),
      ),      
    );
  }
}