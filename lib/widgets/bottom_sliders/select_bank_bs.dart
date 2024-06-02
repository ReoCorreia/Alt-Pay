import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_service/api_bank.dart';
import 'package:flutter_application_1/pages/customer/sign_up/credentials_setup.dart';
import 'package:flutter_application_1/themes/button.dart';
import 'package:flutter_application_1/themes/color.dart';
import 'package:flutter_application_1/themes/snack_bar.dart';
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

  Future<void> getUserBanks() async {
    try {
      List<dynamic> banks = await BankService().getUserBanks();
      if (banks.isNotEmpty) {
        setState(() {
          _banks = banks;
        });
      }
    } catch (e) {
      snackBarError(context, e.toString());
    }
  }    

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,  // Increase height to provide more space for content
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Choose bank to pay with', style: bottomSheetHeading),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _banks.length,                  
                        itemBuilder: (context, index) {
                          var bank = _banks[index];
                          return Row(
                            children: <Widget>[
                              Expanded(child: Image.asset('lib/images/merchant.png', height: 35, width: 35)),
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _bankSelectedId = bank['id'];
                                    });                    
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        bank['account_number'] == null ? '${bank['bank']} ***${bank['iban']}' : '${bank['bank']} ***${bank['account_number']}',
                                        style: const TextStyle(fontSize: 16),
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
                        },
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: SvgPicture.asset('lib/images/add-new.svg', height: 40, width: 40)),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute( builder: (context) => const CredentialSetup()));                    
                              },
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Add Bank',
                                    style: TextStyle(fontSize: 16),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    widget.bankSelected(_bankSelectedId);
                    Navigator.pop(context);
                  },
                  style: themeBtn1, 
                  child: const Text('Confirm')
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
    isScrollControlled: true,  // Allows bottom sheet to expand
    builder: (context) => SelectBank(merchantName: merchantName, payAmount: payAmount, bankSelected: bankSelected),
  );
}
