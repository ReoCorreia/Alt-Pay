import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/report.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/text.dart';
import 'package:flutter_application_1/widgets/bottom_sliders/time_period_bs.dart';
import 'package:flutter_application_1/widgets/bottom_sliders/transaction_bs.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class AppBarTransaction extends StatefulWidget {
  final Function(double, double) filterByAmount;
  final Function(String, String) filterByMonth;
  const AppBarTransaction({super.key, required this.filterByAmount, required this.filterByMonth});

  @override
  State<AppBarTransaction> createState() => _AppBarTransactionState();
}

class _AppBarTransactionState extends State<AppBarTransaction> {
  DateTime _currentDate = DateTime.now();
  String _timePeriod = "Month";

  void _previousMonth(){
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
    });

    String tempMonth = DateFormat('MMMM').format(_currentDate);
    String tempYear = DateFormat('yyyy').format(_currentDate);
    widget.filterByMonth(tempMonth, tempYear);
  }

  void _nextMonth(){
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
    });
    
    String tempMonth = DateFormat('MMMM').format(_currentDate);
    String tempYear = DateFormat('yyyy').format(_currentDate);
    widget.filterByMonth(tempMonth, tempYear);
  }


  @override
  Widget build(BuildContext context) {
    String formattedDate = _timePeriod == "Month" ? DateFormat('MMMM yyyy').format(_currentDate) 
    : DateFormat('yyyy').format(_currentDate);

    return AppBar(
      centerTitle: true,
      backgroundColor: themeColorPrimary,
      automaticallyImplyLeading: false,
      title: Text(
            'Transactions',
            style: themeTextField5,
          ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80), // Adjust height as needed
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(onTap: ()=>{
                _previousMonth()
              }, child: SvgPicture.asset('lib/images/less-than.svg', width: 30, height: 30,),),
              Text(formattedDate, style: themeTextField,),
              GestureDetector(onTap: ()=>{
                _nextMonth()
              }, child: SvgPicture.asset('lib/images/greater-than.svg', width: 30, height: 30,),),
              GestureDetector(onTap: ()=>{
                openTimePeriodBottomSheet(context)
              }, child: SvgPicture.asset('lib/images/time-period.svg', width: 30, height: 30,),),

            ],
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            children: [
              GestureDetector(onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Report()))
              }, child: SvgPicture.asset('lib/images/excel.svg', width: 35, height: 35,)),
              GestureDetector(onTap: ()=>{
                openTransactionBottomSheet(context, widget.filterByAmount)
              }, child: SvgPicture.asset('lib/images/filter.svg', width: 35, height: 35,),),
            ],
          ),
        ),
      ],

    );
  }
}
