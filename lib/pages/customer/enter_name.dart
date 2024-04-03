import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/issue_partner.dart';

class EnterName extends StatefulWidget {

  final String data;

  const EnterName({super.key, required this.data});

  @override
  State<EnterName> createState() => _EnterNameState();
}

class _EnterNameState extends State<EnterName> {

  final TextEditingController _nameController = TextEditingController();

  void saveName(){
    print("Name: ${_nameController.text}");

    if(_nameController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid name')));
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => IssuePartner(name: _nameController.text, phone: widget.data)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Customer SignUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Mobile No.'),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: widget.data),
              ),
            const SizedBox(height: 20.0),
            const Text('Enter Name'),
            TextField(
              controller: _nameController,
              ),
            ElevatedButton(onPressed: saveName, child: const Text('Save')),              
          ],
        ),
      ),
    );
  }
}