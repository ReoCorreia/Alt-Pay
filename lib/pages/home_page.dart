import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/customer_home.dart';
import 'package:flutter_application_1/pages/merchant/qr_image.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_application_1/styles/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  void navigateToCustomerPage(BuildContext context) {
    // Navigate to customer page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CustomerHome()),
    );
  }

  void navigateToMerchantPage(BuildContext context) {
    // Navigate to merchant page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRImage()),
    );
  }  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 242, 242), //3d3d3d 212121
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListView(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Image.asset('lib/images/ap.png', height: 250, width: 250,),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        'A simple, fun, and creative way to \nshare photos, videos, messages\nwith friends and family ',
                        style: TextStyle(
                          color: Color(0xFF777779),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 120),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerHome()));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF464646)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Customer",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFcccccf),
                              fontWeight: FontWeight.bold,
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const QRImage()));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFfc5a3b)),
                            elevation: MaterialStateProperty.all<double>(0),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),                            
                          ),
                          child: const Text(
                            "Merchant",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFcccccf),
                              fontWeight: FontWeight.bold,
                            ),
                          ),                          
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );    
  }
}
