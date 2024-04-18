import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/pages/customer/password_setup.dart';
import 'package:flutter_application_1/themes/app_bar.dart';

import '../../themes/button.dart';
import '../../themes/color.dart';
import '../../themes/hint_style.dart';
import '../../themes/text.dart';

class ValidateComplete extends StatefulWidget {

  final String name, phone, ibanNo, bankingRoutingNo, accountNo;
  const ValidateComplete({super.key, required this.name, required this.phone, required this.ibanNo, required this.bankingRoutingNo, required this.accountNo});

  @override
  State<ValidateComplete> createState() => _ValidateCompleteState();
}

class _ValidateCompleteState extends State<ValidateComplete> {

  void _submit(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordSetup(name: widget.name ,phone: widget.phone)));
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
      onPressed: () => _submit(context),
      style: themeBtn2,
      child: Text(
        'Setup Password',
        style: themeTextField,
      ),
    );
    return btn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Validate Credentials Complete'),
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
              'Your account has been successfully set-up. You can now use the app to make payments at any merchant location in any country where the Alt-Pay sign is displayed',
              style: themeTextField4,
            ),
            const SizedBox(height: 20.0),
            Text(
              'You can now set-up the Application Password to avoid having to use OTP to sign-on, going forward.',
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