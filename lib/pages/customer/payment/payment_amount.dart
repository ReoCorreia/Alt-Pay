import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_service/api_bank.dart';
import 'package:flutter_application_1/api_service/api_transaction.dart';
import 'package:flutter_application_1/pages/customer/payment/payment_amount2.dart';
import 'package:flutter_application_1/pages/customer/dashboard.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';
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
  int _bankId = -1;
  final BankService bankService = BankService();

  @override 
  void dispose(){
    _amount.dispose();
    super.dispose();
  }  
  
  void _bankSelected(int bankId) {
    setState(() {
      _bankId = bankId;
    });
    _getCCYAmount(context, bankId);    
  }        

  Future<void> _getCCYAmount(BuildContext context, int bankId) async{
    if(_bankId != -1){
      try {
        Map<String, dynamic> rates = await transactionService.initiateTransaction(int.parse(_amount.text), widget.data["Point of Initiation Method"]["data"], widget.data["Merchant Name"]["data"], _bankId);
        setState(() {
          _rates = rates;
          _ccyAmountGenerated = true;
        });
      } catch (e) {
        snackBarError(context, "Failed to get CCY Amount $e");
      }
    }else{

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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: 
                    !_ccyAmountGenerated ? ElevatedButton(onPressed: () => {
                      openSelectBankBottomSheet(context, widget.data["Merchant Name"]["data"], _amount.text, _bankSelected)
                    }, style: btnOrange , child: const Text('Get CCY Amount')) 
                    : ElevatedButton(
                      onPressed: () => {
                        setState(() {
                          _ccyAmountGenerated = false;
                        }),                        
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentAmount2(storeName: widget.data["Merchant Name"]["data"], amount: _amount.text, conversionRateApplied: _rates['conversion_rate_applied'].toString(), convertedRate: _rates['amount_origination_country'].toString())))
                        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PaymentAmount2(storeName: widget.data["Merchant Name"]["data"], amount: _amount.text, conversionRateApplied: _rates['conversion_rate_applied'].toString(), convertedRate: _rates['amount_origination_country'].toString())), (route) => false)
                      },
                      style: btnOrange , child: Text('Pay ${_amount.text}')),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(onPressed: () => {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const Dashboard()), (route) => false)
                    }, style: btnBlack , child: const Text('Cancel')),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
}