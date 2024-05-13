import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/transaction.dart';
import 'package:flutter_application_1/themes/app_bar.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {

  List<Transaction> transactions = [
    Transaction(
      id: '1',
      type: 'DEBIT',
      senderName: 'Alice',
      senderAccount: 'alice@upi',
      receiverName: 'Bob',
      receiverAccount: 'bob@upi',
      amount: 100.0,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: '2',
      type: 'DEBIT',
      senderName: 'Charlie',
      senderAccount: 'charlie@upi',
      receiverName: 'Alice',
      receiverAccount: 'alice@upi',
      amount: 50.0,
      timestamp: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: '3',
      type: 'DEBIT',
      senderName: 'David',
      senderAccount: 'david@upi',
      receiverName: 'Alice',
      receiverAccount: 'alice@upi',
      amount: 200.0,
      timestamp: DateTime.now(),
    ),
    Transaction(
      id: '4',
      type: 'DEBIT',
      senderName: 'Eve',
      senderAccount: 'eve@upi',
      receiverName: 'Alice',
      receiverAccount: 'alice@upi',
      amount: 75.0,
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
    ),
    Transaction(
      id: '5',
      type: 'DEBIT',
      senderName: 'Frank',
      senderAccount: 'frank@upi',
      receiverName: 'Alice',
      receiverAccount: 'alice@upi',
      amount: 120.0,
      timestamp: DateTime.now().subtract(Duration(minutes: 30)),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTransactions(context),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: <Widget>[
              Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = transactions[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0), // Add margin for spacing
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                const Expanded(
                                  child: Icon(Icons.payment_sharp)
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('${transaction.senderAccount} to ${transaction.receiverAccount}', overflow: TextOverflow.clip), // Replace with senderAccount and receiverAccount
                                      Text('${transaction.timestamp}', overflow: TextOverflow.clip), // Replace with formatted timestamp
                                    ],
                                  )
                                ),
                                Expanded(
                                  child: Text('\$${transaction.amount.toString()}'), // Replace with formatted amount
                                ),
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
          ),
        ),
    );
  }
}