import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/validate_complete.dart';
import 'package:flutter_application_1/themes/app_bar.dart';

import '../../themes/button.dart';
import '../../themes/color.dart';
import '../../themes/hint_style.dart';
import '../../themes/text.dart';

class ValidateCredentials extends StatefulWidget {

  final String name, phone, ibanNo, bankingRoutingNo, accountNo;
  const ValidateCredentials({super.key, required this.name, required this.phone, required this.ibanNo, required this.bankingRoutingNo, required this.accountNo});

  @override
  State<ValidateCredentials> createState() => _ValidateCredentialsState();
}

class _ValidateCredentialsState extends State<ValidateCredentials> {

  void _validate(BuildContext context){

    Navigator.push(context, MaterialPageRoute(builder: (context) => ValidateComplete(name: widget.name ,phone: widget.phone, ibanNo: widget.ibanNo, bankingRoutingNo: widget.bankingRoutingNo, accountNo: widget.accountNo)));
  }

  void snackBarMessage(error){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            textAlign: TextAlign.center,
            '$error',
            style: themeTextField,
          ).animate().shakeX(hz: 14, curve: Curves.easeInOutCubic),
          backgroundColor: themeBtnOrange
      ),
    );
  }

  Text ibanOrBankingRoutingNo(){
    Text txt = Text(
      (widget.ibanNo.isEmpty) ? 'Banking Routing No: \n${widget.bankingRoutingNo}' : 'IBAN No: \n${widget.ibanNo}',
      style: themeTextField4,
    );
    return txt;
  }

  ElevatedButton btnOrange(){
    ElevatedButton btn = ElevatedButton(
      onPressed: () => _validate(context),
      style: themeBtn2,
      child: Text(
        'Validate',
        style: themeTextField,
      ),
    );
    return btn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Validate Credentials'),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[

            Text(
                'Partner: Monzo',
              style: themeTextField2,
            ),
            const SizedBox(height: 20.0),
            ibanOrBankingRoutingNo(),
            const SizedBox(height: 20.0),
            Text(
              'You will now be redirected to our partner website/app for validation of your credentials',
              style: themeTextField4,
            ),
            const SizedBox(height: 20.0),
            btnOrange(),
          ],
          ),
      ),      
    );
  }
}