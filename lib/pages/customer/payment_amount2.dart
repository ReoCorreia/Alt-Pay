import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/dashboard.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/hint_style.dart';

class PaymentAmount2 extends StatefulWidget {
  final String storeName, amount;
  const PaymentAmount2({super.key, required this.storeName, required this.amount});

  @override
  State<PaymentAmount2> createState() => _PaymentAmount2State();
}

class _PaymentAmount2State extends State<PaymentAmount2> {

  final TextEditingController _billRef = TextEditingController();
  final AuthManager authManager = AuthManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: themeBtnOrange,
          title: Text(
            'Bill',
            style: themeTextField,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app), // Sign out icon
              onPressed: () async {await authManager.signOut(context);}
            ),
          ],
        ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
              Image.asset('lib/images/t-logo.png', height: 200, width: 200,),
              const SizedBox(height: 20.0),
              Text(widget.storeName, style: const TextStyle(fontSize: 28)),
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
                    child: ElevatedButton(
                      onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentAmount2(storeName: widget.storeName, amount: widget.amount)))
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Dashboard()))
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