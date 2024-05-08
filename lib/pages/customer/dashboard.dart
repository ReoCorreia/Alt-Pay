import 'package:flutter_application_1/pages/customer/credentials_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/api_services.dart';
import 'package:flutter_application_1/pages/customer/payment_amount.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>{

  // ignore: unused_field
  String _scanBarcode = '';
  final AuthManager authManager = AuthManager();
  final ApiService apiService = ApiService(); 

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String qrString;

    try {
      qrString = await FlutterBarcodeScanner.scanBarcode(
          '#fff89224', 'Cancel', true, ScanMode.QR);
      if (qrString != "-1") {
        await fetchData(qrString);
      }
    } on PlatformException {
      qrString = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = qrString;
    });
  }

  Future<void> fetchData(String qrString) async {
    Map<String, dynamic> data = await apiService.qrData(qrString);
    Navigator.push(context, MaterialPageRoute( builder: (context) => PaymentAmount(data: data)));
  }  
  
  Widget titleBox(String title) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(title, textAlign: TextAlign.center),
      ),
    );
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDashboard(context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Card(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10.0),
                  //     child: Center(
                  //       child: Column(
                  //         children: <Widget>[
                  //           const Text('Welcome to Alt-Pay'),
                  //           Image.asset('lib/images/t-logo.png', width: 150, height: 150),
                  //           const Text(
                  //             'Our partner in United Kingdom is \nMonzo \nwww.monzo.com',
                  //             style: TextStyle(
                  //               color: Color(0xFF777779),
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 18,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // First Child (Lottie Animation)
                              Expanded(
                                child: Lottie.asset(
                                  'lib/assets/welcome.json',
                                  width: 150,
                                  height: 150,
                                ),
                              ),
                              // Second Child (Buttons)
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    // First Button
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          FloatingActionButton(
                                            onPressed: () => scanQR(),
                                            foregroundColor: themeBtnOrange,
                                            backgroundColor: themeBtnOrange,
                                            child: Image.asset('lib/images/qr-btn-icon.png', width: 30, height: 30,),
                                          ),
                                          const SizedBox(height: 10),
                                          titleBox('Scan QR & Pay'),                        
                                        ],
                                      ),
                                    ),
                                    // Second Button
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          FloatingActionButton(
                                            onPressed: () => scanQR(),
                                            foregroundColor: themeBtnOrange,
                                            backgroundColor: themeBtnOrange,
                                            child: Image.asset('lib/images/plus-1.png', width: 30, height: 30,),
                                          ),
                                          const SizedBox(height: 10),
                                          titleBox('New Payment'),                        
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          FloatingActionButton(
                                            onPressed: () => {Navigator.push(context, MaterialPageRoute( builder: (context) => const CredentialSetup()))},
                                            foregroundColor: themeBtnOrange,
                                            backgroundColor: themeBtnOrange,
                                            child: SvgPicture.asset('lib/images/bank-logo.svg', width: 30, height: 30,),
                                          ),
                                          const SizedBox(height: 10),
                                          titleBox('Add Bank'),                        
                                        ],
                                      ),
                                    ),
                      
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),            
          ],
        ),
      ),
    );
  }
}
