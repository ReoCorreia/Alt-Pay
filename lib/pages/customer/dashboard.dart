import 'package:flutter_application_1/model/transaction.dart';
import 'package:flutter_application_1/pages/customer/credentials_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/api_service/api_services.dart';
import 'package:flutter_application_1/pages/customer/payment_amount.dart';
import 'package:flutter_application_1/pages/customer/transactions.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/text_style.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

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

  List<Transaction> transactions = [
    Transaction(
      id: '1',
      type: 'DEBIT',
      senderName: 'Alice',
      senderAccount: 'alice@upi',
      receiverName: 'Bob',
      receiverAccount: 'bob@upi',
      amount: 100.0,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: '2',
      type: 'DEBIT',
      senderName: 'Charlie',
      senderAccount: 'charlie@upi',
      receiverName: 'Alice',
      receiverAccount: 'alice@upi',
      amount: 50.0,
      timestamp: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: '3',
      type: 'DEBIT',
      senderName: 'David',
      senderAccount: 'david@upi',
      receiverName: 'Alice',
      receiverAccount: 'alice@upi',
      amount: 200.0,
      timestamp: DateTime.now(),
    ),
    Transaction(
      id: '4',
      type: 'DEBIT',
      senderName: 'Eve',
      senderAccount: 'eve@upi',
      receiverName: 'Alice',
      receiverAccount: 'alice@upi',
      amount: 75.0,
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
    ),
    Transaction(
      id: '5',
      type: 'DEBIT',
      senderName: 'Frank',
      senderAccount: 'frank@upi',
      receiverName: 'Alice',
      receiverAccount: 'alice@upi',
      amount: 120.0,
      timestamp: DateTime.now().subtract(Duration(minutes: 30)),
    ),
  ];
  
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
      snackBarError(context, 'Error Scanning QR $e');
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
    transactions.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return Scaffold(
      appBar: appBarDashboard(context),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => scanQR(),
        foregroundColor: themeBtnOrange,
        backgroundColor: themeBtnOrange,
        child: SvgPicture.asset('lib/images/qr-btn-icon.svg', width: 30, height: 30,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,      
      bottomNavigationBar: const _DemoBottomAppBar(
        fabLocation: FloatingActionButtonLocation.centerDocked,
        shape: CircularNotchedRectangle(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
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
                                            foregroundColor: themeOrange,
                                            backgroundColor: themeOrange,
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
                  const SizedBox(height: 20.0),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(flex: 6, child: Text('Recent Transactions', style: cardHeading),),
                          Expanded(child: GestureDetector(
                            onTap:() => {
                              Navigator.push(context, MaterialPageRoute( builder: (context) => const Transactions()))
                            },
                            child: const Text('View All', style: TextStyle(decoration: TextDecoration.underline),),
                          )),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5.0), // Add margin for spacing
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    const Expanded(
                                      child: Icon(Icons.payment_sharp)
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('${transaction.senderAccount} to ${transaction.receiverAccount}', overflow: TextOverflow.clip), // Replace with senderAccount and receiverAccount
                                          Text('${transaction.timestamp}', overflow: TextOverflow.clip), // Replace with formatted timestamp
                                        ],
                                      )
                                    ),
                                    Expanded(
                                      child: Text('\$${transaction.amount.toString()}'), // Replace with formatted amount
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          ],
                        ),
                      ),
                    ],
                  ),                ],
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
