import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_service/api_services.dart';
import 'package:flutter_application_1/pages/customer/sign_up/issue_partner.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/text.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';
import 'package:flutter_application_1/themes/text_field_decoration.dart';

class EnterName extends StatefulWidget {

  final String data;

  const EnterName({super.key, required this.data});

  @override
  State<EnterName> createState() => _EnterNameState();
}

class _EnterNameState extends State<EnterName> {

  final ApiService apiService = ApiService();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> saveName() async{
    
    if(_firstName.text.isEmpty){
      snackBarError(context, 'Please fill First Name');
    }else if(_lastName.text.isEmpty){
      snackBarError(context, 'Please fill Last Name');
    }else if(_emailController.text.isEmpty){
      snackBarError(context, 'Please fill Email Id');
    }

    if(!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(_emailController.text)){
      snackBarError(context, 'Email address invalid');
      return;
    }

    try {
      String userName = '${_firstName.text} ${_lastName.text}';
      await apiService.updateUserData(widget.data, userName, widget.data.substring(0, 2), _emailController.text);
      snackBarMessage(context, 'Details  saved successfully');
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => IssuePartner(name: userName, phone: widget.data)));
    } catch (e) {
      snackBarError(context, 'Error Saving User details: $e');
    }
  }

  ElevatedButton btnOrange(){
    ElevatedButton btn = ElevatedButton(
      onPressed: () => saveName(), 
      style: themeBtn2,
      child: Text(
        'Save',
        style: themeTextField,                
      ),
    );
    return btn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('User Details'),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 30.0),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(text: widget.data),
                keyboardType: TextInputType.phone,
                decoration: decorate('Phone')
              ),
              const SizedBox(height: 20,),  
              TextFormField(
                controller: _firstName,
                keyboardType: TextInputType.name,
                decoration: decorate('First Name')
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _lastName,
                keyboardType: TextInputType.name,
                decoration: decorate('Last Name')
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: decorate('Email')                
              ),
              const SizedBox(height: 20,),                          
              btnOrange()              
            ],
          ),
        ),
      ),
    );
  }
}