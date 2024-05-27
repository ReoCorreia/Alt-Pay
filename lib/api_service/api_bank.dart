import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/sessions/auth_manager.dart';

class BankService{

  final AuthManager authManager = AuthManager();

  static const String _baseUrl = 'http://65.1.187.138:8000';
  static const String _apiDomain = "65.1.187.138:8000";

  // endpoints
  static const String _addBankEndpoint = '/users/v1/add_bank';
  static const String _getUserBanks = '/users/v1/get_user_banks';  

  Future<List<dynamic>> getUserBanks() async{
    final String? authToken = await authManager.getAuthToken();
    var url = Uri.http(
        _apiDomain, _getUserBanks);

    final response = await http.get(url, headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authToken.toString()      
    });

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (!jsonResponse['error']) {
      print(jsonResponse);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to get transaction: ${jsonResponse['message']}');
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

}