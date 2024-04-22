import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ApiService{
  final AuthManager authManager = AuthManager();

  static const String _baseUrl = 'http://65.1.187.138:8000';

  // endpoints
  static const String _loginEndpoint = '/users/v1/login';
  static const String _signUpEndpoint = '/users/v1/send_otp';
  static const String _verifyOTPEndpoint = '/users/v1/verify_otp';
  static const String _addDeviceEndpoint = '/users/v1/add_device';
  static const String _addBankEndpoint = '/users/v1/add_bank';

  Future<void> login() async{

    var response = await http.post(
      Uri.parse(_baseUrl + _loginEndpoint),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "mobile": '+498423421234', //api does not accept any mobile
        "password": 'test' //api does not accept any pass other than 'test' yet
      }),
    );
    
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    
    if (!jsonResponse['error']) {        
      await authManager.saveAuthToken(jsonResponse['data']);
    } else {
      throw Exception('${jsonResponse['message']}');
    }
  }  

  Future<Map<String, dynamic>> addDevice() async{
    dynamic deviceInfo;
    final deviceInfoPlugin = DeviceInfoPlugin();
    final String? authToken = await authManager.getAuthToken();
    final String? mobile = await authManager.getMobile();

    if (!kIsWeb) { // kIsWeb to ensure that the code is not running on web
      if (Platform.isAndroid) {
        deviceInfo = await deviceInfoPlugin.androidInfo;
      } else if(Platform.isIOS){
        deviceInfo = await deviceInfoPlugin.iosInfo;
      } else {
        throw Exception('Could not fetch device info');
      }
    }

    var response = await http.post(
      Uri.parse(_baseUrl + _addDeviceEndpoint),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authToken.toString()
      },
      body: jsonEncode(<String, String>{
        "mobile": mobile.toString(),
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
      return jsonResponse;
    } else {
      throw Exception('${jsonResponse['message']}');
    }
  }

  Future<http.Response> receiveOTP(String mobile) async{
    return await http.post(
      Uri.parse(_baseUrl + _signUpEndpoint),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobile': mobile,
        'type': "signup"
      }),
    );
  }

    Future<bool> verifyOTP(String mobile, String otp) async{
    var response = await http.post(
      Uri.parse(_baseUrl + _verifyOTPEndpoint),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "mobile": mobile,
        "otp": otp
      }),
    );
    Map<String,dynamic> jsonResponse = jsonDecode(response.body);
      if (!jsonResponse['error']) {
        print(jsonResponse['data']['OTPVerified']);
        return jsonResponse['data']['OTPVerified'];
      } else {
        throw Exception('Failed to verify: ${jsonResponse['message']}');
      }
  }

  Future<Map<String, dynamic>> addBank(String name, String phone, String bankingRoutingNo, String iban, String accountNo, String bank) async{
      var response = await http.post(
        Uri.parse(_baseUrl + _addBankEndpoint),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'gAAAAABmIN1LP2Hz8XWjtlQGnZpNlxCWfkybWuRKvgA0xmt-DRVhi_z6IS-qPIO3Bw7q44fR0XL8aiUCvagHSJgaCoYyi987UjGhtsbp3jLpNtO7PHwbot9HrI6UhUbf9Hg1GuZmjSmx-PTrmkRT85F9NtrcpjXNfQ=='
        },
        body: jsonEncode(<String, String>{
          "mobile": phone,
          "iban": iban,
          "bank_routing_number": bankingRoutingNo,
          "account_number": accountNo,
          "bank": bank
        }),
      );
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (!jsonResponse['error']) {
        return jsonResponse;
      } else {
        throw Exception('Failed to add bank: ${jsonResponse['message']}');
      }    
  }


}