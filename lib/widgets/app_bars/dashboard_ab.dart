import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/text.dart';
import 'package:flutter_application_1/themes/text_style.dart';
import 'package:flutter_application_1/widgets/bottom_sliders/transaction_bs.dart';
import 'package:flutter_svg/svg.dart';

class AppBarDashboard extends StatelessWidget {
  final Function(double, double) filterCallback;
  const AppBarDashboard({super.key, required this.filterCallback});  

  @override
  Widget build(BuildContext context) {
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
              GestureDetector(onTap: ()=>{}, child: SvgPicture.asset('lib/images/less-than.svg', width: 30, height: 30,),),
              Text('May 2024', style: themeTextField,),
              GestureDetector(onTap: ()=>{}, child: SvgPicture.asset('lib/images/greater-than.svg', width: 30, height: 30,),),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(onTap: ()=>{
            openTransactionBottomSheet(context, filterCallback)
          }, child: SvgPicture.asset('lib/images/filter.svg', width: 35, height: 35,),),
        ),
      ],

    );
  }
}
