import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/dashboard.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/text_field_decoration.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/hint_style.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_application_1/variables/api_variables.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool incorrectPhone = false;
  bool incorrectPassword = false;
  String mobile = "";
  
  final TextEditingController _password = TextEditingController();

  final deviceInfoPlugin = DeviceInfoPlugin();  

  Future<void> _submit(BuildContext context) async{

    if(mobile.isEmpty){
      setState(() {
        incorrectPhone = true;
      });
      snackBarMessage('Phone Incorrect');     
      return;
    }else if(_password.text.isEmpty){
      setState(() {
        incorrectPassword = true;
      });      
      snackBarMessage('Password Incorrect');
      return;
    }else{      
      await addDevice();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
    }    
  }

  Future<Map<String, dynamic>> addDevice() async{
    dynamic deviceInfo;

    if (!kIsWeb) { // kIsWeb to ensure that the code is not running on web
      if (Platform.isAndroid) {
        deviceInfo = await deviceInfoPlugin.androidInfo;
      } else if(Platform.isIOS){
        deviceInfo = await deviceInfoPlugin.iosInfo;
      } else {
        snackBarMessage('Server error: try again after sometime');
        throw Exception('Could not fetch device info');
      }
    }

    var response = await http.post(
      Uri.parse('http://$apiDomain/users/v1/add_device'),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'gAAAAABmIN1LP2Hz8XWjtlQGnZpNlxCWfkybWuRKvgA0xmt-DRVhi_z6IS-qPIO3Bw7q44fR0XL8aiUCvagHSJgaCoYyi987UjGhtsbp3jLpNtO7PHwbot9HrI6UhUbf9Hg1GuZmjSmx-PTrmkRT85F9NtrcpjXNfQ=='
      },
      body: jsonEncode(<String, String>{
        "mobile": mobile,
        "device_id": deviceInfo.version.sdkInt.toString(), //serial no
        "make": deviceInfo.manufacturer,
        "model": deviceInfo.model,
        "os": Platform.isAndroid ? "Android" : "IOS",
        "imei1": "string",
        "imei2": "string"
      }),
    );
    
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    
    if (!jsonResponse['error']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            textAlign: TextAlign.center,
            'Sign In Successful',
            style: whiteSnackBar            
          ), 
          backgroundColor: textWhite
        ),
      );        
      return jsonResponse;
    } else {
      snackBarMessage(jsonResponse["message"]);
      throw Exception('${jsonResponse['message']}');
    }
  }

  void snackBarMessage(String error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            textAlign: TextAlign.center,
            error,
            style: themeTextField,            
          ).animate().shakeX(hz: 14, curve: Curves.easeInOutCubic), 
          backgroundColor: themeBtnOrange
        ),
      );    
  }  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Sign In'),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            Image.asset('lib/images/login.png', width: 300, height: 300),
            Row(
                children: [
                  Expanded(
                    child: IntlPhoneField(
                      initialCountryCode: 'GB',
                      disableLengthCheck: true,
                      decoration: decorate('Enter your phone'),
                      onChanged: (phone) {
                          setState(() {
                            mobile = phone.completeNumber;
                          });                        
                      },
                    ),
                  ),
                  // const SizedBox(width: 20.0),
                ],
              ).animate(target: incorrectPhone? 1 : 0).shakeX(hz: 14, curve: Curves.easeInOutCubic),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    obscureText: true,
                    decoration: decorate('Enter your password'),
                    controller: _password,
                  ).animate(target: incorrectPassword? 1 : 0).shakeX(hz: 14, curve: Curves.easeInOutCubic),
                ),
              ],
            ),

            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _submit(context), 
              style: themeBtn2,
              child: Text(
                'Sign In',
                style: themeTextField,                
              ),
            ),
          ],
        ),
        ),
    );
  }

  item(String name, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }  
}

