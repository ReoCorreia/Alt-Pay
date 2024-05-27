import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_application_1/pages/customer/login/sign_in.dart';
import 'package:flutter_application_1/pages/customer/sign_up/sign_up.dart';

import 'package:flutter_application_1/themes/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/themes/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color.fromARGB(255, 244, 242, 242), //3d3d3d 212121
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
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
                                // Color(0xFFFFE5DC),
                                Color(0xFFf89224),
                                Color(0xFFf89224),                                
                                // Color(0xFFFC7A69),
                                // Color(0xFFFC7A69),
                                // Color(0xFFB3E5FC), // Lighter shade of blue
                                // Color(0xFF015A78),                             
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 0,
                        child: Image.asset(
                          'lib/images/clipper-logo.png',
                          width: 150, // Adjust width as needed
                          height: 100, // Adjust height as needed
                          fit: BoxFit.fitWidth, // Adjust the fit as needed                          
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Image.asset(
                      'lib/images/t-logo.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Pay using QR Codes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
                        },
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
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn()));
                        },
                        style: themeBtn2,
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.getFont(
                            'Lato',
                            fontSize: 18,
                            color: textWhite,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .5,
                          ),                            
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );    
  }
}
