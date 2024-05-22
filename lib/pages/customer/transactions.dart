import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_service/api_transaction.dart';
import 'package:flutter_application_1/helper/date_format.dart';
import 'package:flutter_application_1/themes/text.dart';
import 'package:flutter_application_1/widgets/app_bars/transaction_ab.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {

  final TransactionService transactionService = TransactionService();
  Map<String, dynamic> _filteredTransactions = {};

  @override 
  void initState() { 
    fetchTransactions();  
    super.initState(); 
  }   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(180), child: AppBarTransaction(filterByAmount: filterTransactionsByAmount, filterByMonth: filterTransactionsByMonth,)),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
          child: _filteredTransactions.isEmpty ? const Center(child: CircularProgressIndicator()) 
          : ListView(
              children: <Widget>[
                Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _filteredTransactions['data'].length,
                          itemBuilder: (context, index) {
                            var transaction = _filteredTransactions['data'][index];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10.0), // Add margin for spacing
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SvgPicture.asset('lib/images/transaction-icon.svg', width: 25, height: 25,),
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('${transaction['merchant_name']}', overflow: TextOverflow.ellipsis, style: transactionHeadingText,), // Replace with senderAccount and receiverAccount
                                          Text(formatTransactionDate(transaction['transaction_date']), overflow: TextOverflow.ellipsis, style: transactionTimeText,), // Replace with formatted timestamp
                                        ],
                                      ),
                                    )
                                  ),
                                  Text('LKR ${transaction['amount_recipient_country']}'),
                                ],
                              ),
                            );
                          },
                        ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
        ),
    );
  }

  Future<void> fetchTransactions() async{
    Map<String, dynamic> transactions =  await transactionService.getAllTransactions();
    // Serialize transactions to JSON string
    String transactionsJson = jsonEncode(transactions);

    // Save transactions to Shared Preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('transactions', transactionsJson);    
    
    setState(() {
      _filteredTransactions = transactions;
    });
  }

  Future<void> loadFilteredTransactionsFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? transactionsJson = prefs.getString('transactions');
    if (transactionsJson != null) {
      Map<String, dynamic> transactions = jsonDecode(transactionsJson);
      setState(() {
        _filteredTransactions = transactions;
      });
    }
  }

  Future<void> filterTransactionsByAmount(double minAmount, double maxAmount) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? transactionsJson = prefs.getString('transactions');
    if (transactionsJson != null) {
      Map<String, dynamic> transactions = jsonDecode(transactionsJson);
      setState(() {
        _filteredTransactions = transactions;
      });
    }
    if(minAmount != maxAmount){
      setState(() {
        // Use the 'where' method to filter transactions by amount range
        _filteredTransactions['data'] = _filteredTransactions['data'].where((transaction) {
          double amount = transaction['amount_recipient_country']; // Assuming 'amount_recipient_country' holds the transaction amount as a string
          return amount >= minAmount && amount <= maxAmount;
        }).toList();
      });
    }
  }

  Future<void> filterTransactionsByMonth(String month, String year) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? transactionsJson = prefs.getString('transactions');
    
    if (transactionsJson != null) {
      Map<String, dynamic> transactions = jsonDecode(transactionsJson);
      setState(() {
        _filteredTransactions = transactions;
      });
    }

    setState(() {
      _filteredTransactions['data'] = _filteredTransactions['data'].where((transaction) {
        Map<String, String> formattedData = formatTransactionDateMap(transaction['transaction_date']);
        String currTransactionMonth = formattedData['month'].toString();
        String currTransactionYear =  formattedData['year'].toString();
        return month == currTransactionMonth && year == currTransactionYear;
      }).toList();
    });
  }


  void clearFilters() {
    loadFilteredTransactionsFromPrefs();
  }

}