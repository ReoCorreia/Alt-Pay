import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_service/api_transaction.dart';
import 'package:flutter_application_1/helper/save_report.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;

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
        print(_startDate);
        print(_endDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Account Statement'),
        leading: IconButton(onPressed: (() => {}), icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(child: SvgPicture.asset('lib/images/excel-1.svg', width: 150, height: 150),),
          Expanded(
            child: Column(
              children: <Widget>[
                const Text('Time Period'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      onPressed: () => _selectDate(context, true),
                      child: Text(_startDate == null ? _dateFormat.format(DateTime.now().subtract(const Duration(days: 30))) : _dateFormat.format(_startDate!)),
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                      onPressed: () => _selectDate(context, false),
                      child: Text(_endDate == null ? _dateFormat.format(DateTime.now()) : _dateFormat.format(_endDate!)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                const Text('Get your statement'),
                ElevatedButton(onPressed: () => {
                  if(_startDate != null && _endDate != null){
                    downloadReport(_startDate, _endDate)
                  }
                }, child: const Text('Download Button'))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> downloadReport(DateTime? startDate, DateTime? endDate) async{
    Map<String, dynamic> transactions = await transactionService.getAllTransactions();
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
        
    print(transactions['data']);
    generateExcel(transactions['data']);
  }

  Future<void> generateExcel(List<dynamic> transactions) async{
    final xcel.Workbook workbook = xcel.Workbook(); 
    final xcel.Worksheet sheet = workbook.worksheets[0];
        
    sheet.getRangeByIndex(1, 1).setText("transaction_type"); 
    sheet.getRangeByIndex(1, 2).setText("amount_recipient_country");
    sheet.getRangeByIndex(1, 3).setText("merchant_name");
    sheet.getRangeByIndex(1, 4).setText("transaction_status");
    sheet.getRangeByIndex(1, 5).setText("transaction_id");
    sheet.getRangeByIndex(1, 6).setText("transaction_date");
    sheet.getRangeByIndex(1, 7).setText("recipient_country");
    sheet.getRangeByIndex(1, 8).setText("origination_country");
    sheet.getRangeByIndex(1, 9).setText("bank");
    sheet.getRangeByIndex(1, 10).setText("iban");
    sheet.getRangeByIndex(1, 11).setText("bank_routing_number");
    sheet.getRangeByIndex(1, 12).setText("account_number");

    for (var i = 0; i < transactions.length; i++) { 
        final item = transactions[i];
        sheet.getRangeByIndex(i + 2, 1).setText(item["transaction_type"].toString()); 
        sheet.getRangeByIndex(i + 2, 2).setText(item["amount_recipient_country"].toString());
        sheet.getRangeByIndex(i + 2, 3).setText(item["merchant_name"].toString());
        sheet.getRangeByIndex(i + 2, 4).setText(item["transaction_status"].toString());
        sheet.getRangeByIndex(i + 2, 5).setText(item["transaction_id"].toString());
        sheet.getRangeByIndex(i + 2, 6).setText(item["transaction_date"].toString());
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
      await saveExcel(bytes);
    } catch (e) {
      print(e);
    }       
  }

}