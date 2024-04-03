import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/customer_home.dart';
import 'package:flutter_application_1/pages/merchant/qr_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  void _navigateToCustomerPage(BuildContext context) {
    // Navigate to customer page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CustomerHome()),
    );
  }

  void _navigateToMerchantPage(BuildContext context) {
    // Navigate to merchant page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRImage()),
    );
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
              const Text('Welcome To',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

            Image.asset('lib/images/lankapay.png', width: 150, height: 130),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _navigateToCustomerPage(context),
                  child: const Text('Customer'),
                ),
                const SizedBox(width: 40), // Adjust spacing between buttons as needed
                ElevatedButton(
                  onPressed: () => _navigateToMerchantPage(context),
                  child: const Text('Merchant'),
                  
                ),
              ],
            ),
          ],
        ),         
      ),      
    );
  }
}