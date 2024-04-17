import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/payment_amount.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/hint_style.dart';
import 'package:flutter_application_1/variables/api_variables.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  // ignore: unused_field
  String _scanBarcode = '';

  @override
  void initState() {
    super.initState();
  }

Future<void> scanQR(BuildContext context) async {
  String qrString;

  try {
    qrString = await FlutterBarcodeScanner.scanBarcode(
        '#fffc5a3b', 'Cancel', true, ScanMode.QR);
    if (qrString != "-1") {
      print("Upi url: $qrString");
      await fetchData(context, qrString);
    }
  } on PlatformException {
    qrString = 'Failed to get platform version.';
  }

  if (!mounted) return;

  setState(() {
    _scanBarcode = qrString;
  });
}

Future<void> fetchData(BuildContext context, String qrString) async {
  var url = Uri.http(
      apiDomain, '/masters/v1/decodeLankaQR/', {'qrstring': qrString});

  final response = await http.get(url);
  var jsonResponse = jsonDecode(response.body);
  var data = jsonResponse['data'];

  // Navigate to the next page while passing the data as arguments
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PaymentAmount(data: data),
    ),
  );
}  

  void snackBarMessage(String error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            textAlign: TextAlign.center,
            error,
            style: themeTextField,            
          ).animate().shakeX(hz: 14, curve: Curves.easeInOutCubic), 
          backgroundColor: themeBtnOrange
        ),
      );    
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
      backgroundColor: themeBtnOrange,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: themeBtnOrange,
          title: Text(
            textAlign: TextAlign.center,
            'Dashboard',
            style: themeTextField,            
          )
      ),      
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Text('Welcome to Lanka-Pay'),
                          SizedBox(height: 20.0),
                          Text(
                            'Our partner in United Kingdom is \nMonzo \nwww.monzo.com',
                            style: TextStyle(
                              color: Color(0xFF777779),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),                      
                    ), 
                  ),
                  Card(
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // First Child (Lottie Animation)
                            Expanded(
                              child: Lottie.asset(
                                'lib/assets/welcome.json',
                                width: 175,
                                height: 175,
                              ),
                            ),
                            // Second Child (Buttons)
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  // First Button
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        FloatingActionButton(
                                          onPressed: () => scanQR(context),
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
                                          onPressed: () => scanQR(context),
                                          foregroundColor: themeBtnOrange,
                                          backgroundColor: themeBtnOrange,
                                          child: Image.asset('lib/images/plus-1.png', width: 30, height: 30,),
                                        ),
                                        const SizedBox(height: 10),
                                        titleBox('New Payment'),                        
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
                ],
              ),
            ),            
          ],
        ),
      ),
    );
  }
}
