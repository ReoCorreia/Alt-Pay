import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/dashboard.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/text.dart';
import 'package:flutter_application_1/themes/text_field_decoration.dart';

class PaymentAmount2 extends StatefulWidget {
  final String storeName, amount, conversionRateApplied, convertedRate;
  const PaymentAmount2({super.key, required this.storeName, required this.amount, required this.conversionRateApplied, required this.convertedRate});

  @override
  State<PaymentAmount2> createState() => _PaymentAmount2State();
}

class _PaymentAmount2State extends State<PaymentAmount2> {

  final TextEditingController _billRef = TextEditingController();
  final AuthManager authManager = AuthManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarAfterSignIn(context),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
              const SizedBox(height: 30.0),
              Text(widget.storeName, style: const TextStyle(fontSize: 28)),
              const SizedBox(height: 20.0),
              Text('MCY Amount: LKR ${widget.amount} \nExchange Rate: LKR ${widget.conversionRateApplied} \nCCY Amount: EUR ${widget.convertedRate}'),
              const Divider(
                color: Colors.black,
                thickness: 2,
                height: 20,
              ),
              const SizedBox(height: 20.0),         
              const Text('Partner Monzo | Approved \nPartner Ref No.: 91292929293'),
              const SizedBox(height: 20.0),
              const Divider(
                color: Colors.black,
                thickness: 2,
                height: 20,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _billRef,
                decoration: decorate('Enter Bill Ref No.')
                ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentAmount2(storeName: widget.storeName, amount: widget.amount, conversionRateApplied: widget.conversionRateApplied, convertedRate: widget.convertedRate)))
                    }, 
                    style: themeBtn2,
                    child: Text('Bill Photo Using Camera', textAlign: TextAlign.center, style: themeTextField)
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: ElevatedButton(onPressed: () => {}, style: themeBtn2, child: Text('Upload Bill File', textAlign: TextAlign.center, style: themeTextField)),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Divider(
                color: Colors.black,
                thickness: 2,
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Dashboard()))
                    }, style: themeBtn2, child: Text('Submit & Continue', textAlign: TextAlign.center, style: themeTextField)),
                  ),
                  const SizedBox(width: 25.0),
                  Expanded(
                    child: ElevatedButton(onPressed: () => {
                      Navigator.pop(context)
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> const Dashboard()))
                    }, style: themeBtn2, child: Text('Cancel', textAlign: TextAlign.center, style: themeTextField)),
                  ),
                ],
              ), 
          ],
        ),
      ),
    );
  }
}