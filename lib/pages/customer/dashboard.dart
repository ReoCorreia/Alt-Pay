import 'package:flutter_application_1/pages/customer/credentials_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/api_services.dart';
import 'package:flutter_application_1/pages/customer/payment_amount.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/text_style.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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
          qrColor, 'Cancel', true, ScanMode.QR);
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
    try {
      Map<String, dynamic> data = await apiService.qrData(qrString);
      if (data.isNotEmpty) {
        Navigator.push(context, MaterialPageRoute( builder: (context) => PaymentAmount(data: data)));
      }else{
        snackBarError(context, 'Error Scanning QR');  
      }
    // ignore: unused_catch_clause
    } on Exception catch (e) {
      snackBarError(context, 'Error Scanning QR');
    }
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
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => scanQR(),
        foregroundColor: themeBtnOrange,
        backgroundColor: themeBtnOrange,
        child: Image.asset('lib/images/qr-btn-icon.png', width: 30, height: 30,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,      
      bottomNavigationBar: const _DemoBottomAppBar(
        fabLocation: FloatingActionButtonLocation.centerDocked,
        shape: CircularNotchedRectangle(),
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.black12)
                    ),
                    child: Card(
                      color: const Color.fromARGB(255, 251, 249, 249),
                      margin: const EdgeInsets.all(0),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Money Transfer', style: cardHeading,),
                            const SizedBox(height: 20.0,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
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

class _DemoBottomAppBar extends StatelessWidget {
  const _DemoBottomAppBar({
    this.fabLocation = FloatingActionButtonLocation.centerDocked,
    this.shape = const CircularNotchedRectangle(),
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: shape,
      color: themeOrange,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Home',
              icon: const Icon(Icons.home),
              onPressed: () {},
            ),
            if (centerLocations.contains(fabLocation)) const Spacer(),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.person),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.favorite),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
