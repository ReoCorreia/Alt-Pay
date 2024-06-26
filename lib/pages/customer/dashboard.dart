import 'package:flutter_application_1/api_service/api_transaction.dart';
import 'package:flutter_application_1/helper/date_format.dart';
import 'package:flutter_application_1/pages/customer/sign_up/credentials_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/api_service/api_services.dart';
import 'package:flutter_application_1/pages/customer/payment/payment_amount.dart';
import 'package:flutter_application_1/pages/customer/transactions/transactions.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:flutter_application_1/themes/app_bar.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/text.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';
import 'package:flutter_application_1/widgets/loaders/jumping_dots.dart';
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
  bool _transactionsFetched = false;
  
  @override
  void initState() {
    fetchTransactions();
    setState(() {
      _transactionsFetched = true;
    });
    super.initState();
  }

  @override
  void dispose() {
    Navigator.pop(context, _filteredTransactions);
    super.dispose();
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
      backgroundColor: const Color(0xFFFFFAF0),
      appBar: appBarDashboard(context),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: CircleBorder(
          side: BorderSide(
            color: lightGrey
          )
        ),
        onPressed: () => scanQR(),
        foregroundColor: whitest,
        backgroundColor: whitest,
        child: SvgPicture.asset('lib/images/qr-btn-icon.svg', width: 30, height: 30,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,      
      bottomNavigationBar: const _DemoBottomAppBar(
        fabLocation: FloatingActionButtonLocation.centerDocked,
        shape: CircularNotchedRectangle(),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // Shadow color
                        offset: const Offset(0, 4), // Horizontal and vertical offset
                        blurRadius: 10, // Blur radius
                        spreadRadius: 2, // Spread radius                        
                      ),
                    ],
                    color: whitest,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: whitest,
                      width: 2
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Money Transfer', style: cardHeading,),
                      const SizedBox(height: 20.0,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                // First Button
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      FloatingActionButton(
                                        elevation: 0,
                                        shape: CircleBorder(
                                          side: BorderSide(
                                            color: lightGrey
                                          )
                                        ),
                                        onPressed: () => scanQR(),
                                        foregroundColor: whitest,
                                        backgroundColor: whitest,
                                        child: SvgPicture.asset('lib/images/qr-btn-icon.svg', width: 30, height: 30,),
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
                                        elevation: 0,
                                        shape: CircleBorder(
                                          side: BorderSide(
                                            color: lightGrey
                                          )
                                        ),
                                        onPressed: () => scanQR(),
                                        foregroundColor: whitest,
                                        backgroundColor: whitest,
                                        child: SvgPicture.asset('lib/images/plus.svg', width: 30, height: 30,),
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
                                        elevation: 0,
                                        shape: CircleBorder(
                                          side: BorderSide(
                                            color: lightGrey
                                          )
                                        ),
                                        onPressed: () => {Navigator.push(context, MaterialPageRoute( builder: (context) => const CredentialSetup()))},
                                        foregroundColor: whitest,
                                        backgroundColor: whitest,
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
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // Shadow color
                      offset: const Offset(0, 4), // Horizontal and vertical offset
                      blurRadius: 10, // Blur radius
                      spreadRadius: 2, // Spread radius                        
                    ),
                  ],
                  color: whitest,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    color: whitest,
                    width: 2
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(flex: 5, child: Text('Recent Transactions', style: cardHeading),),
                          Expanded(child: GestureDetector(
                            onTap:() => {
                              Navigator.push(context, MaterialPageRoute( builder: (context) => const Transactions()))
                            },
                            child: const Text('View All', style: TextStyle(decoration: TextDecoration.underline),),
                          )),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      !_transactionsFetched ? const Center(child: ThreeDotsLoader())
                      : _filteredTransactions.isEmpty ? Center(child: Text('No Transactions', style: themeTextField2,)) 
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
                                          Text('${transaction['merchant_name']}', overflow: TextOverflow.clip, style: transactionHeadingText,), // Replace with senderAccount and receiverAccount
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

Future<void> fetchTransactions() async {
  Map<String, dynamic> response = await transactionService.getAllTransactions('45', '0');
  List<Map<String, dynamic>> transactions = (response['data'] as List<dynamic>).cast<Map<String, dynamic>>();
    
  // Sort transactions in descending order by transaction_date
  transactions.sort((a, b) => b['transaction_date'].compareTo(a['transaction_date']));

  setState(() {
    _filteredTransactions = transactions.take(5).toList();
  });
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
              onPressed: () {
                snackBarMessage(context, 'home');
              },
            ),
            if (centerLocations.contains(fabLocation)) const Spacer(),
            IconButton(
              tooltip: 'Transactions',
              icon: const Icon(Icons.payment),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute( builder: (context) => const Transactions()));
              },
            ),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.person),
              onPressed: () {
                snackBarMessage(context, 'profile page');
              },
            ),            
          ],
        ),
      ),
    );
  }
}
