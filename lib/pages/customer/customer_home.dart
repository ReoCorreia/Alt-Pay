import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/sign_in.dart';
import 'package:flutter_application_1/pages/customer/sign_up.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({super.key});

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {

  void _navigateToSignUp(BuildContext context) {
    // Navigate to customer page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUp()),
    );
  }

  void _navigateToMerchantPage(BuildContext context) {
    // Navigate to merchant page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignIn()),
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
                  onPressed: () => _navigateToSignUp(context),
                  child: const Text('Sign Up'),
                ),
                const SizedBox(width: 40), // Adjust spacing between buttons as needed
                ElevatedButton(
                  onPressed: () => _navigateToMerchantPage(context),
                  child: const Text('Sign In'),
                  
                ),
              ],
            ),
          ],
        ),         
      ),      
    );
  }
}