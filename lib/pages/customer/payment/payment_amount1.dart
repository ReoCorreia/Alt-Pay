import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/payment/payment_amount2.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/text.dart';

class PaymentAmount1 extends StatefulWidget {
  final String storeName, amount;
  const PaymentAmount1({super.key, required this.storeName, required this.amount});

  @override
  State<PaymentAmount1> createState() => _PaymentAmount1State();
}

class _PaymentAmount1State extends State<PaymentAmount1> {

  final AuthManager authManager = AuthManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarAfterSignIn(context),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              const SizedBox(height: 30.0),
              const Text('MCY Amount: LKR 3361.00 \nExchange Rate: LKR 336.10 \nCCY Amount: EUR 10.00'),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentAmount2(storeName: widget.storeName, amount: widget.amount)))
                    }, style: themeBtn2, child: Text('Pay', style: themeTextField)),
                  ),
                  const SizedBox(width: 25.0),
                  Expanded(
                    child: ElevatedButton(onPressed: () => {}, style: themeBtn1, child: Text('Cancel', style: themeTextField)),
                  ),
                ],
              ),
          ],
        ),

      ),
    );
  }
}