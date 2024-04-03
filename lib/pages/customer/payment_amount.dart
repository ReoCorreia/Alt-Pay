import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/payment_amount1.dart';

class PaymentAmount extends StatefulWidget {
  const PaymentAmount({super.key});

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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('New Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'BeachSide DEli',
              style: TextStyle(
                fontSize: 28,
              ),
              ),
              const SizedBox(height: 20.0),
              const Text('Enter amount:'),
              TextFormField(
                controller: _amount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Please enter amount',
                ),
              ),
              const SizedBox(height: 20.0),
              const Text('EUR Exchange Rate: LKR 336.10'),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(onPressed: () => _getCCYAmount(context), child: const Text('Get CCY Amount')),
                  ),
                  const SizedBox(width: 25.0),
                  Expanded(
                    child: ElevatedButton(onPressed: () => {}, child: const Text('Cancel')),
                  ),                  
                ],
              ),                            
          ],
        ),
        ),      
    );
  }
}