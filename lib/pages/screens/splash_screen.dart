import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Future.delayed(const Duration(seconds: 2), _navigateToHome);
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => const HomePage(),
    ));
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('lib/images/Android (1).png', height: 25, width: 25,),
      ),
    );
  }
}
