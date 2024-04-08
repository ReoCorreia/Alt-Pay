import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/sign_in.dart';
import 'package:flutter_application_1/pages/customer/sign_up.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/hint_style.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:google_fonts/google_fonts.dart';

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
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: themeBtnOrange,
      //   title: Text(
      //     'Sign In',
      //     style: themeTextField,
      //   ),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                    ClipPath(
                      clipper: WaveClipperTwo(),
                      child: Container(
                        width: double.infinity,
                        height: 120.0,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFFf99321),
                              Color(0xFFfc5a3b),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),              
              const Text(
                'Welcome To',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20), // Adjust vertical spacing as needed
              Image.asset(
                'lib/images/t-logo.png',
                width: 250,
              ),
              const SizedBox(height: 20), // Adjust vertical spacing as needed
              ElevatedButton(
                onPressed: () => _navigateToSignUp(context),
                style: themeBtn1,
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.getFont(
                    'Lato',
                    fontSize: 18,
                    color: textWhite,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .7,
                  ),
                ),
              ),
              const SizedBox(height: 10), // Adjust vertical spacing between buttons as needed
              ElevatedButton(
                onPressed: () => _navigateToMerchantPage(context),
                style: themeBtn2,
                child: Text(
                  'Sign In',
                  style: themeTextField,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}