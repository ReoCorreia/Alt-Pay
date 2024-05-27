import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/login/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<String?> getSignUpAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('signUpAuthToken');
  }  

  Future<String?> getMobile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('mobile_number');
  }  

  Future<Map<String, dynamic>?> getAuthData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Check if the authToken exists to determine if other data should be fetched
    String? authToken = prefs.getString('authToken');
    if (authToken == null) {
      return null; // Return null if no authToken is found
    }

    // Create a map to hold all the authentication data
    Map<String, dynamic> authData = {
      'authToken': authToken,
      'country': prefs.getString('country') ?? '', // Using ?? to provide a default value (REMOVE LATER)
      'mobile_number': prefs.getString('mobile_number') ?? '',
      'user_name': prefs.getString('user_name') ?? '',
      'altpay_qr_code': prefs.getString('altpay_qr_code') ?? '',
    };

    return authData;
  }

  Future<void> saveAuthToken(Map<String, dynamic> response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', response['auth_token'] ?? 'found null');
    await prefs.setString('country', response['country'] ?? 'found null');
    await prefs.setString('mobile_number', response['mobile_number'] ?? 'found null');
    await prefs.setString('user_name', response['user_name'] ?? 'found null');
    await prefs.setString('altpay_qr_code', response['altpay_qr_code'] ?? 'found null');
  }

  Future<void> saveSignUpAuthToken(String authToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('signUpAuthToken', authToken);
  }  

  Future<void> removeAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> signOut(BuildContext context) async {
    await removeAuthToken();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const SignIn()), ((route) => false));
  }  
}
