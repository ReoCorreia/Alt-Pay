import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/text.dart';

class SelectBank extends StatefulWidget {
  final String payAmount;
  const SelectBank({super.key, required this.payAmount});

  @override
  State<SelectBank> createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  bool _viewBanksArrow = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: !_viewBanksArrow ? 240 : 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Choose bank to pay with', style: bottomSheetHeading),
          ),
          Row(
            children: <Widget>[
              Expanded(child: Image.asset('lib/images/merchant.png', height: 40, width: 40)),
              const Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Federal Bank ***2546',
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,  // Prevents overflow by showing ellipsis
                    ),
                    Text(
                      'Savings Account',
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => {
                    setState(() {
                      _viewBanksArrow = !_viewBanksArrow;
                    })                    
                  },
                  child: const Icon(Icons.arrow_drop_down),
                )
              ),
            ],
          ),
          _viewBanksArrow
          ? Row(
            children: <Widget>[
              Expanded(child: Image.asset('lib/images/merchant.png', height: 40, width: 40)),
              const Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'HDFC Bank ***7819',
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,  // Prevents overflow by showing ellipsis
                    ),
                    Text(
                      'Current Account',
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => {
                    setState(() {
                      _viewBanksArrow = !_viewBanksArrow;
                    })                    
                  },
                  child: const Icon(Icons.arrow_drop_down),
                )
              ),
            ],
          )
          : const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(onPressed: () =>{}, 
                  style: themeBtn1, child: Text('Pay LKR ${widget.payAmount}')
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void openSelectBankBottomSheet(BuildContext context, String payAmount) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: whitest,
    builder: (context) => SelectBank(payAmount: payAmount),
  );
}