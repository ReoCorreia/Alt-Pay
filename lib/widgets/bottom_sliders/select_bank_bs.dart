import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_service/api_bank.dart';
import 'package:flutter_application_1/pages/customer/sign_up/credentials_setup.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectBank extends StatefulWidget {
  final String payAmount;
  final String merchantName;
  final Function(int) bankSelected;
  const SelectBank({super.key, required this.payAmount, required this.merchantName, required this.bankSelected});

  @override
  State<SelectBank> createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  final BankService bankService = BankService();
  List<dynamic> _banks = [];
  int _bankSelectedId = -1;

  @override 
  void initState() {
    getUserBanks();
    super.initState();
  }

  Future<void> getUserBanks() async{
    try {
      List<dynamic> banks = await BankService().getUserBanks();
      
      if (banks.isNotEmpty) {
        setState(() {
          _banks = banks;
        });
      }
      
    } catch (e) {
      print(e);
    }
  }    

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Choose bank to pay with', style: bottomSheetHeading),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _banks.length,                  
                  itemBuilder: (context, index) {
                    var bank = _banks[index];
                    return Row(
                        children: <Widget>[
                          Expanded(child: Image.asset('lib/images/merchant.png', height: 40, width: 40)),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () => {
                                setState(() {
                                  _bankSelectedId = bank['id'];
                                })                    
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${bank['bank']} ***${bank['account_number']}',
                                    style: const TextStyle(fontSize: 18),
                                    overflow: TextOverflow.ellipsis,  // Prevents overflow by showing ellipsis
                                  ),
                                  const Text(
                                    'Savings Account',
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: _bankSelectedId == bank['id'] ? const Icon(Icons.check) : const SizedBox()
                          ),
                        ],
                      );
                  }
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(child: SvgPicture.asset('lib/images/add-new.svg', height: 40, width: 40)),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute( builder: (context) => const CredentialSetup()))                    
                  },
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Add Bank',
                        style: TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,  // Prevents overflow by showing ellipsis
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox()
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(onPressed: () =>{
                  widget.bankSelected(_bankSelectedId),
                  Navigator.pop(context)
                }, 
                  style: themeBtn1, child: const Text('Generate CCY Amount')
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void openSelectBankBottomSheet(BuildContext context, String merchantName, String payAmount, Function(int) bankSelected) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: whitest,
    builder: (context) => SelectBank(merchantName: merchantName, payAmount: payAmount, bankSelected: bankSelected),
  );
}