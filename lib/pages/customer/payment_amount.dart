import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/payment_amount1.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/button.dart';

class PaymentAmount extends StatefulWidget {
  final Map<String, dynamic> data;
  const PaymentAmount({super.key, required this.data});

  @override
  State<PaymentAmount> createState() => _PaymentAmountState();
}

class _PaymentAmountState extends State<PaymentAmount> {
  final TextEditingController _amount = TextEditingController();

  void _getCCYAmount(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentAmount1()));
  }

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('New Payment'),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('lib/images/merchant.png', height: 40, width: 40),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.data["Merchant Name"]["data"],
                        style: const TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.data["Merchant Category Code"]["description"],
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60.0),
            Center(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    textAlign: TextAlign.center,
                    controller: _amount,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: '   0',
                    ),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),                  
                  const Text('EUR Exchange Rate: LKR 336.10'),                  
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(onPressed: () => _getCCYAmount(context), style: themeBtn2 ,child: const Text('Get CCY Amount')),
                ),
                const SizedBox(width: 25.0),
                Expanded(
                  child: ElevatedButton(onPressed: () => {}, style: themeBtn1 ,child: const Text('Cancel')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}