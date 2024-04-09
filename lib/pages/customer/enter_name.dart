import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/issue_partner.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/hint_style.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class EnterName extends StatefulWidget {

  final String data;

  const EnterName({super.key, required this.data});

  @override
  State<EnterName> createState() => _EnterNameState();
}

class _EnterNameState extends State<EnterName> {

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void saveName(){
    if(_firstName.text.isEmpty){
      snackBarMessage('Please fill First Name');
    }else if(_lastName.text.isEmpty){
      snackBarMessage('Please fill Last Name');
    }else if(_emailController.text.isEmpty){
      snackBarMessage('Please fill Email Id');
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => IssuePartner(name: "abcd", phone: widget.data)));
    }
  }

  void snackBarMessage(error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            textAlign: TextAlign.center,
            '${error}',
            style: themeTextField,            
          ).animate().shakeX(hz: 14, curve: Curves.easeInOutCubic), 
          backgroundColor: themeBtnOrange
        ),
      );    
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: themeBtnOrange,
        title: Text(
          'User Details',
          style: themeTextField,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            TextField(
              readOnly: true,
              controller: TextEditingController(text: widget.data),
              ),
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0), // Apply border radius
                border: Border.all(color: themeBtnOrange), // Define border color and width
              ),              
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your Email Id',
                  hintStyle: GoogleFonts.getFont(
                    'Lato',
                    fontWeight: FontWeight.w500,
                    letterSpacing: .7,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),                  
                ),                
              ),
            ),
            const SizedBox(height: 20,),            
            TextField(
              controller: _firstName,
              ),
            const SizedBox(height: 20,),
            TextField(
              controller: _lastName,
              ),
            const SizedBox(height: 20,),              
            btnOrange()              
          ],
        ),
      ),
    );
  }
}