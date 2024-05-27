import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_service/api_transaction.dart';
import 'package:flutter_application_1/helper/save_report.dart';
import 'package:flutter_application_1/pages/customer/transactions/transactions.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';
import 'package:flutter_application_1/themes/text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import 'package:permission_handler/permission_handler.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  DateTime? _startDate;
  DateTime? _endDate;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');  // Define the date format

  final TransactionService transactionService = TransactionService();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void daysButtonPicked(int days){
    DateTime startDate = DateTime.now().subtract(Duration(days: days));
    DateTime endDate = DateTime.now();
    downloadReport(startDate, endDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Account Statement'),
        leading: IconButton(onPressed: (() => {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Transactions()))
        }), icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(child: SvgPicture.asset('lib/images/excel-1.svg', width: 150, height: 150),),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Time Period', style: themeTextField2),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints){
                        final double containerWidth = constraints.maxWidth * 0.3; // 80% of parent width
                        final double containerHeight = constraints.maxHeight * 0.6; // 40% of parent height                        
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(onTap: () => {daysButtonPicked(30)}, child: Container(width: containerWidth, height: containerHeight, decoration: BoxDecoration(border: Border.all(color: grey), color: lightGrey, borderRadius: const BorderRadius.all(Radius.circular(20))), child: const Center(child: Text('Last 30 Days', textScaler: TextScaler.linear(1.0))))),
                            GestureDetector(onTap: () => {daysButtonPicked(60)}, child: Container(width: containerWidth, height: containerHeight, decoration: BoxDecoration(border: Border.all(color: grey), color: lightGrey, borderRadius: const BorderRadius.all(Radius.circular(20))), child: const Center(child: Text('Last 60 Days', textScaler: TextScaler.linear(1.0))),)),
                            GestureDetector(onTap: () => {daysButtonPicked(90)}, child: Container(width: containerWidth, height: containerHeight, decoration: BoxDecoration(border: Border.all(color: grey), color: lightGrey, borderRadius: const BorderRadius.all(Radius.circular(20))), child: const Center(child: Text('Last 90 Days', textScaler: TextScaler.linear(1.0))))),
                          ],
                        );
                      },
                    )
                  ),
                  Expanded(child: Text('OR', style: themeTextField4,)),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          style: datePicker,
                          onPressed: () => _selectDate(context, true),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(_startDate == null ? _dateFormat.format(DateTime.now().subtract(const Duration(days: 30))) : _dateFormat.format(_startDate!)),
                              const Icon(Icons.date_range_outlined)               
                            ]
                          ),
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          style: datePicker,
                          onPressed: () => _selectDate(context, false),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(_endDate == null ? _dateFormat.format(DateTime.now()) : _dateFormat.format(_endDate!)),
                              const Icon(Icons.date_range_outlined)
                            ]
                           ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  style: excelButton,
                  onPressed: () => {
                  if(_startDate != null && _endDate != null){
                    downloadReport(_startDate, _endDate)
                  }else{
                    snackBarMessage(context, 'Please select start and end date')
                  }
                }, child: const Text('Download Excel'))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> downloadReport(DateTime? startDate, DateTime? endDate) async{
    Map<String, dynamic> transactions = await transactionService.getAllTransactions('45', '0');
    int startDateTimestamp = startDate!.millisecondsSinceEpoch;
    int endDateTimestamp = endDate!.millisecondsSinceEpoch; 
    
    //filter between start and end date
    transactions['data'] = transactions['data'].where((transaction) {
      String dateString = transaction['transaction_date'];
      // Parse the date string into a DateTime object
      DateTime dateTime = DateTime.parse(dateString);
      
      // Convert the DateTime object into a timestamp (milliseconds since epoch) => easy for time comparison
      int currTransactionTimestamp = dateTime.millisecondsSinceEpoch;
            
      return currTransactionTimestamp <= endDateTimestamp && currTransactionTimestamp >= startDateTimestamp;
    }).toList();    
        
    // print(transactions['data']);
    generateExcel(transactions['data']);
  }

  Future<void> generateExcel(List<dynamic> transactions) async{
    final xcel.Workbook workbook = xcel.Workbook(); 
    final xcel.Worksheet sheet = workbook.worksheets[0];
        
    sheet.getRangeByIndex(1, 1).setText("Transaction Type"); 
    sheet.getRangeByIndex(1, 2).setText("Amount Recipient Country");
    sheet.getRangeByIndex(1, 3).setText("Merchant Name");
    sheet.getRangeByIndex(1, 4).setText("Transaction Status");
    sheet.getRangeByIndex(1, 5).setText("Transaction Id");
    sheet.getRangeByIndex(1, 6).setText("Transaction Date");
    sheet.getRangeByIndex(1, 7).setText("Recipient Country");
    sheet.getRangeByIndex(1, 8).setText("Origination Country");
    sheet.getRangeByIndex(1, 9).setText("Bank");
    sheet.getRangeByIndex(1, 10).setText("IBAN");
    sheet.getRangeByIndex(1, 11).setText("Bank Routing Number");
    sheet.getRangeByIndex(1, 12).setText("Account Number");

    for (var i = 0; i < transactions.length; i++) { 
        final item = transactions[i];
        sheet.getRangeByIndex(i + 2, 1).setText(item["transaction_type"].toString()); 
        sheet.getRangeByIndex(i + 2, 2).setText(item["amount_recipient_country"].toString());
        sheet.getRangeByIndex(i + 2, 3).setText(item["merchant_name"].toString());
        sheet.getRangeByIndex(i + 2, 4).setText(item["transaction_status"].toString());
        sheet.getRangeByIndex(i + 2, 5).setText(item["transaction_id"].toString());
        sheet.getRangeByIndex(i + 2, 6).setText(DateTime.parse(item["transaction_date"]).toString());
        sheet.getRangeByIndex(i + 2, 7).setText(item["recipient_country"].toString());
        sheet.getRangeByIndex(i + 2, 8).setText(item["origination_country"].toString());
        sheet.getRangeByIndex(i + 2, 9).setText(item["bank"].toString());
        sheet.getRangeByIndex(i + 2, 10).setText(item["iban"].toString());
        sheet.getRangeByIndex(i + 2, 11).setText(item["bank_routing_number"].toString());
        sheet.getRangeByIndex(i + 2, 12).setText(item["account_number"].toString());         
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    try {
      var status = await Permission.storage.status;
        if (status.isDenied) {
          showAlertDialog(context);
        }else{
          String outputFileName = "$_startDate-$_endDate";
          await saveExcel(context, bytes, outputFileName);
        }      
    } catch (e) {
      print(e);
    }       
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Storage Permission Required"),
          content: const Text("This app needs storage access to save files."),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Settings"),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }
}