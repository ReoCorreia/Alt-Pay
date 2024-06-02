import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_service/api_transaction.dart';
import 'package:flutter_application_1/pages/customer/payment/payment_amount2.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';
import 'package:flutter_application_1/themes/text_field_decoration.dart';

class PasswordDialogBox extends StatefulWidget {
  final int bankId;
  final int amount;
  final String pointOfInitiation;
  final String merchantName;
  const PasswordDialogBox({super.key, required , required this.amount, required this.pointOfInitiation, required this.merchantName, required this.bankId});

  @override
  State<PasswordDialogBox> createState() => _PasswordDialogBoxState();
}

class _PasswordDialogBoxState extends State<PasswordDialogBox> {
  
  Map<String, dynamic> _transaction = {};
  TextEditingController _password = TextEditingController();
  TransactionService transactionService = TransactionService();

  bool _passwordPolicy(){
    RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');

    if(regex.hasMatch(_password.text)){
      return true;
    }else{
      snackBarError(context, 'Weak Password');
      return false;
    }
  }

  Future<void> _initiateTransaction(BuildContext context) async{
    try {
      Map<String, dynamic> transaction = await transactionService.initiateTransaction(widget.amount, widget.pointOfInitiation, widget.merchantName, widget.bankId);
      setState(() {
        _transaction = transaction;
      });
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PaymentAmount2(storeName: widget.merchantName, amount: widget.amount.toString(), conversionRateApplied: _transaction['conversion_rate_applied'].toString(), convertedRate: _transaction['amount_origination_country'].toString())), (route) => false);      
    } catch (e) {
      snackBarError(context, "Transaction Failed $e");
    }    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Password'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              obscureText: true,
              decoration: decorate('Enter your password'),
              controller: _password,
            ),
            ElevatedButton(
              onPressed: () => {
                if(_passwordPolicy()){
                  _initiateTransaction(context)
                }
              },
              style: btnBlack, 
              child: const Text('Submit'),
            )
          ],
         ),
      ),
    );
  }
}

void openFullScreenDialog(BuildContext context, int amount, String pointOfInitiation, String merchantName, int bankId) {
  Navigator.of(context).push(MaterialPageRoute<void>(
    fullscreenDialog: true,
    builder: (BuildContext context) {
      return PasswordDialogBox(amount: amount, pointOfInitiation: pointOfInitiation, merchantName: merchantName, bankId: bankId);
    },
  ));
}