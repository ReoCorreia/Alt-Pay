import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/customer/payment_amount.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/hint_style.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            const  Text('Welcome to Lanka-Pay'),
            const SizedBox(height: 20.0),
            const Text(
              'Our partner in United Kingdom is \nMonzo \nwww.monzo.com',
              style: TextStyle(
                color: Color(0xFF777779),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () => scanQR(),
                style: themeBtn1,
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('lib/images/qr-btn-icon.png', width: 30, height: 30,),
                      Text('Scan QR & Pay', style: themeTextField)                    
                    ],
                  ),
                ),                
                // child: Text('Scan QR & Pay', style: themeTextField,)
            ),
            ElevatedButton(
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentAmount()))
                },
                style: themeBtn2,
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('lib/images/plus-1.png', width: 30, height: 30,),
                      Text('New Payment', style: themeTextField)                    
                    ],
                  ),
                ),
                // child: Text('New Payment', style: themeTextField)
            ),
          ],
        ),
      ),
    );
  }
}