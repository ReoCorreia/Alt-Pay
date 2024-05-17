import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_service/api_transaction.dart';
import 'package:flutter_application_1/helper/date_format.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/text.dart';
import 'package:flutter_application_1/themes/text_style.dart';
import 'package:flutter_application_1/widgets/transaction_bottom_sheet.dart';
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

  void clearFilters() {
    print('object');
    loadFilteredTransactionsFromPrefs();
  }


  @override 
  void initState() { 
    fetchTransactions();  
    super.initState(); 
  }   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: themeOrange,
        automaticallyImplyLeading: false,
        title: Text(
              'Transactions',
              style: themeTextField5,
            ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80), // Adjust height as needed
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(onTap: ()=>{}, child: SvgPicture.asset('lib/images/less-than.svg', width: 30, height: 30,),),
                Text('May 2024', style: themeTextField,),
                GestureDetector(onTap: ()=>{}, child: SvgPicture.asset('lib/images/greater-than.svg', width: 30, height: 30,),),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(onTap: ()=>{
            openTransactionBottomSheet(context, filterTransactionsByAmount)              
              // transactionBottomSheet(context, filterCallback)
            }, child: SvgPicture.asset('lib/images/filter.svg', width: 35, height: 35,),),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
          child: _filteredTransactions.isEmpty ? const Center(child: CircularProgressIndicator()) 
          : ListView(
              children: <Widget>[
                ElevatedButton(onPressed: () => {clearFilters()}, child: const Text('clear filter')),
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
                                          Text('${transaction['merchant_name']}', overflow: TextOverflow.ellipsis, style: themeTextField2,), // Replace with senderAccount and receiverAccount
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

  Future<Map<String, dynamic>> fetchTransactions() async{
    Map<String, dynamic> transactions =  await transactionService.getAllTransactions();
    // Serialize transactions to JSON string
    String transactionsJson = jsonEncode(transactions);

    // Save transactions to Shared Preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('transactions', transactionsJson);    
    
    setState(() {
      _filteredTransactions = transactions;
    });
    // print(transactions);
    return _filteredTransactions;
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
}