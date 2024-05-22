import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_service/api_transaction.dart';
import 'package:flutter_application_1/pages/customer/dashboard.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';
import 'package:flutter_application_1/themes/text.dart';
import 'package:flutter_application_1/widgets/bottom_sliders/select_bank_bs.dart';

class PaymentAmount extends StatefulWidget {
  final Map<String, dynamic> data;
  const PaymentAmount({super.key, required this.data});

  @override
  State<PaymentAmount> createState() => _PaymentAmountState();
}

class _PaymentAmountState extends State<PaymentAmount> {

  bool _ccyAmountGenerated = false;
  late Map<String, dynamic> _rates;
  final TextEditingController _amount = TextEditingController();
  final AuthManager authManager = AuthManager();
  final TransactionService transactionService = TransactionService();

  Future<void> _getCCYAmount(BuildContext context) async{
    try {
      Map<String, dynamic> rates = await transactionService.initiateTransaction(int.parse(_amount.text), widget.data["Point of Initiation Method"]["data"], widget.data["Merchant Name"]["data"]);
      setState(() {
        _rates = rates;
        _ccyAmountGenerated = true;
      });
    } catch (e) {
      snackBarError(context, "Failed to get CCY Amount $e");
    }
    // Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentAmount1(storeName: widget.data["Merchant Name"]["data"], amount: _amount.text)));
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        
        appBar: AppBar(
          leading: IconButton(onPressed: (()=>{
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const Dashboard()), (route) => false)
          }), icon: const Icon(Icons.close)),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app), // Sign out icon
              onPressed: () async {await authManager.signOut(context);}
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('lib/images/merchant.png', height: 40, width: 40),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.data["Merchant Name"]["data"],
                          style: const TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,  // Prevents overflow by showing ellipsis
                        ),
                        Text(
                          widget.data["Merchant Category Code"]["description"],
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Expanded(
                        child: Text(
                          'LKR',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Expanded(
                        flex: 3, // Adjust flex as needed to balance the layout
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          onChanged: (value) => setState(() {
                            _ccyAmountGenerated = false;
                          }),
                          controller: _amount,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: '0',
                          ),
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),                  
                  _ccyAmountGenerated ? Text('MCY Amount: LKR ${_amount.text} \nExchange Rate: LKR ${_rates['conversion_rate_applied']} \nCCY Amount: EUR ${_rates['amount_origination_country']}') : const SizedBox(),                  
                ],
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: 
                    _ccyAmountGenerated ? ElevatedButton(onPressed: () => {
                      openSelectBankBottomSheet(context, _amount.text)
                    }, style: themeBtn2 , child: Text('Pay', style: themeTextField, textAlign: TextAlign.center,)) 
                    : ElevatedButton(onPressed: () => _getCCYAmount(context), style: themeBtn2 , child: Text('Get CCY Amount', style: themeTextField, textAlign: TextAlign.center,)),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: ElevatedButton(onPressed: () => {}, style: themeBtn1 , child: Text('Cancel', style: themeTextField)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
}