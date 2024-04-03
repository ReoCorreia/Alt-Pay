import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/dashboard.dart';

class PaymentAmount2 extends StatefulWidget {
  const PaymentAmount2({super.key});

  @override
  State<PaymentAmount2> createState() => _PaymentAmount2State();
}

class _PaymentAmount2State extends State<PaymentAmount2> {

  final TextEditingController _billRef = TextEditingController();

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
          children: [
            Image.asset('lib/images/lankapay.png', width: 250, height: 230),
              const Text('BeachSide Deli', style: TextStyle(fontSize: 28)),
              const SizedBox(height: 20.0),
              const Text('MCY Amount: LKR 3361.00 \nExchange Rate: LKR 336.10 \nCCY Amount: EUR 10.00'),
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
              const Text('Enter bill Ref No.'),
              TextField(
                controller: _billRef,
                decoration: const InputDecoration(
                  hintText: 'Enter Bill Ref No.',
                ),
                ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const PaymentAmount2()))
                    }, child: const Text(
                      'Bill Photo Using Camera',
                      textAlign: TextAlign.center,
                      )
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: ElevatedButton(onPressed: () => {}, child: const Text('Upload Bill File')),
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
                    }, child: const Text('Submit & Continue')),
                  ),
                  const SizedBox(width: 25.0),
                  Expanded(
                    child: ElevatedButton(onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Dashboard()))
                    }, child: const Text('Cancel')),
                  ),                  
                ],
              ),                            
          ],
        ),

      ),
    );
  }
}