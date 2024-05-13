import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/sessions/auth_manager.dart';

class TransactionService{

  final AuthManager authManager = AuthManager();

  static const String _baseUrl = 'http://65.1.187.138:8000';
  static const String _apiDomain = "65.1.187.138:8000";

  // endpoints
  static const String _initiateTransaction = '/users/v1/initiate_transaction';
  static const String _getTransaction = '/users/v1/transactions/{transaction_id}';
  static const String _allTransactions = '/users/v1/transactions/?transactionType=DEBIT';  

  Future<Map<String, dynamic>> getTransaction(String transactionId) async{
    final String? authToken = await authManager.getAuthToken();
    var url = Uri.http(
        _apiDomain, _getTransaction, {'transactionId': transactionId});

    final response = await http.get(url, headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authToken.toString()      
    });

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (!jsonResponse['error']) {
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to get transaction: ${jsonResponse['message']}');
    }    
  }

    Future<Map<String, dynamic>> getAllTransactions() async{
    final String? authToken = await authManager.getAuthToken();
    var url = Uri.http(
        _apiDomain, _allTransactions, {'transactionType': "DEBIT"});

    final response = await http.get(url, headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authToken.toString()      
    });

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (!jsonResponse['error']) {
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to transactions: ${jsonResponse['message']}');
    }    
  } 

  Future<void> initiateTransaction() async{
    final String? authToken = await authManager.getAuthToken();
    var response = await http.post(
      Uri.parse(_baseUrl + _initiateTransaction),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authToken.toString()
      },
      body: jsonEncode(<String, dynamic>{
        "origination_country": "Germany",
        "recipient_country": "Sri Lanka",
        "transaction_type": "DEBIT",
        "amount_recipient_country": 300,
        "user_bank_id": 11
      }),
    );
    
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    
    if (!jsonResponse['error']) {        
      await authManager.saveAuthToken(jsonResponse['data']);
    } else {
      throw Exception('${jsonResponse['message']}');
    }
  }

}