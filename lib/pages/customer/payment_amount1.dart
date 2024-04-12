import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/payment_amount2.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/button.dart';

class PaymentAmount1 extends StatefulWidget {
  const PaymentAmount1({super.key});

  @override
  State<PaymentAmount1> createState() => _PaymentAmount1State();
}

class _PaymentAmount1State extends State<PaymentAmount1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('CCY Amount'),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('lib/images/t-logo.png', width: 250, height: 230),
              const SizedBox(height: 20.0),
              const Text('MCY Amount: LKR 3361.00 \nExchange Rate: LKR 336.10 \nCCY Amount: EUR 10.00'),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const PaymentAmount2()))
                    }, style: themeBtn2, child: const Text('Pay')),
                  ),
                  const SizedBox(width: 25.0),
                  Expanded(
                    child: ElevatedButton(onPressed: () => {}, style: themeBtn1, child: const Text('Cancel')),
                  ),                  
                ],
              ),              
          ],
        ),

      ),
    );
  }
}