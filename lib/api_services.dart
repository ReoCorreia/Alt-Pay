import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ApiService{

  final AuthManager authManager = AuthManager();

  static const String _baseUrl = 'http://65.1.187.138:8000';
  static const String _apiDomain = "65.1.187.138:8000";

  // endpoints
  static const String _loginEndpoint = '/users/v1/login';
  static const String _signUpEndpoint = '/users/v1/send_otp';
  static const String _verifyOTPEndpoint = '/users/v1/verify_otp';
  static const String _addDeviceEndpoint = '/users/v1/add_device';
  static const String _addBankEndpoint = '/users/v1/add_bank';
  static const String _lankaQrDetailsEndpoint = '/masters/v1/decodeLankaQR/';
  static const String _updateUserDetails = '/users/v1/update_user'; // same url for password setup and updating user data

  Future<void> login(String mobile, String password) async{
    var response = await http.post(
      Uri.parse(_baseUrl + _loginEndpoint),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "mobile": mobile,
        "password": password
      }),
    );
    
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    
    if (!jsonResponse['error']) {  
      print(jsonResponse);      
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

  Future<Map<String, dynamic>> receiveOTP(String mobile) async{
    var response = await http.post(
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

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if(jsonResponse.containsKey('error')){
      if (!jsonResponse['error']) {
        return jsonResponse;
      } else{
        throw Exception(jsonResponse['message']);  
      }      
    } else{
      throw Exception(jsonResponse['detail']);
    }     
  }

  Future<http.Response> signInViaOTP(String mobile) async{
    return await http.post(
      Uri.parse(_baseUrl + _signUpEndpoint),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobile': mobile,
        'type': "login"
      }),
    );
  }  

  Future<bool> verifySignUpOTP(String mobile, String otp) async{
    var response = await http.post(
      Uri.parse(_baseUrl + _verifyOTPEndpoint),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'type': 'signup'
      },
      body: jsonEncode(<String, String>{
        "mobile": mobile,
        "otp": otp
      }),
    );
    Map<String,dynamic> jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    if (!jsonResponse['error']) {
      await authManager.saveSignUpAuthToken(jsonResponse['data']['auth_token']);
      return jsonResponse['data']['OTPVerified'];
    } else {
      throw Exception('Failed to verify: ${jsonResponse['message']}');
    }
  }

    Future<bool> verifyLoginOTP(String mobile, String otp) async{
      var response = await http.post(
        Uri.parse(_baseUrl + _verifyOTPEndpoint),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'type': 'login'
        },
        body: jsonEncode(<String, String>{
          "mobile": mobile,
          "otp": otp
        }),
      );
      Map<String,dynamic> jsonResponse = jsonDecode(response.body);
      if (!jsonResponse['error']) {
        await authManager.saveAuthToken(jsonResponse['data']['user_data']);
        return jsonResponse['data']['OTPVerified'];
      } else {
        throw Exception('Failed to verify: ${jsonResponse['message']}');
      }
  }  

  Future<Map<String, dynamic>> addBank(String name, String phone, String bankingRoutingNo, String iban, String accountNo, String bank) async{
      final String? authToken = await authManager.getAuthToken();
      var response = await http.post(
        Uri.parse(_baseUrl + _addBankEndpoint),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken.toString()
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

  Future<Map<String, dynamic>> qrData(String qrString) async{
    var url = Uri.http(
        _apiDomain, _lankaQrDetailsEndpoint, {'qrstring': qrString});

    final response = await http.get(url);
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (!jsonResponse['error']) {
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to add bank: ${jsonResponse['message']}');
    }    
  }

  Future<Map<String, dynamic>> updateUserData(String mobile, String userName, String countryId, String emailId) async{
    final String? signUpAuthToken = await authManager.getSignUpAuthToken();
    var response = await http.put(
      Uri.parse(_baseUrl + _updateUserDetails),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': signUpAuthToken.toString()
      },
      body: jsonEncode(<String, String>{
        "mobile": mobile,
        "user_name": userName,
        "country_id": countryId,
        "email_id": emailId        
      }),
    );
    
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (!jsonResponse['error']) {
      return jsonResponse;
    } else {
      throw Exception('${jsonResponse['message']}');
    }
  }    

  Future<Map<String, dynamic>> setPassword(String mobile, String password) async{
    final String? signUpAuthToken = await authManager.getSignUpAuthToken();
    var response = await http.put(
      Uri.parse(_baseUrl + _updateUserDetails),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': signUpAuthToken.toString()
      },
      body: jsonEncode(<String, String>{
        "mobile": mobile,
        "password_hash": password        
      }),
    );
    
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    
    if (!jsonResponse['error']) {
      print(jsonResponse);
      return jsonResponse;
    } else {
      throw Exception('${jsonResponse['message']}');
    }
  }    

}