import 'package:flutter_application_1/api_service/api_transaction.dart';
import 'package:flutter_application_1/helper/date_format.dart';
import 'package:flutter_application_1/pages/customer/credentials_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/api_service/api_services.dart';
import 'package:flutter_application_1/pages/customer/payment_amount.dart';
import 'package:flutter_application_1/pages/customer/transactions.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/text.dart';
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
  final TransactionService transactionService = TransactionService();
  List<dynamic> _filteredTransactions = [];
  
  @override
  void initState() {
    fetchTransactions();
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
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      _filteredTransactions.isEmpty ? const Center(child: CircularProgressIndicator()) 
                      : Column(
                          children: _filteredTransactions.map((transaction) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SvgPicture.asset('lib/images/transaction-icon.svg', width: 25, height: 25,),
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('${transaction['transaction_id']}', overflow: TextOverflow.ellipsis, style: themeTextField2,), // Replace with senderAccount and receiverAccount
                                          Text(formatTransactionDate(transaction['transaction_date']), overflow: TextOverflow.ellipsis, style: transactionTimeText,), // Replace with formatted timestamp
                                        ],
                                      ),
                                    )
                                  ),
                                  Text('LKR ${transaction['amount_recipient_country']}'),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

Future<void> fetchTransactions() async {
  Map<String, dynamic> response = await transactionService.getAllTransactions();
  List<Map<String, dynamic>> transactions = (response['data'] as List<dynamic>).cast<Map<String, dynamic>>();
    
  // Sort transactions in descending order by transaction_date
  transactions.sort((a, b) => b['transaction_date'].compareTo(a['transaction_date']));

  setState(() {
    _filteredTransactions = transactions.take(5).toList();
  });

  print(_filteredTransactions[0]['id']);
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
