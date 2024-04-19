import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/customer/dashboard.dart';
import 'package:flutter_application_1/pages/screens/splash_screen.dart';
import 'package:flutter_application_1/sessions/auth_manager.dart';
import 'pages/home_page.dart';
import 'pages/customer/customer_home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthManager authManager = AuthManager();
  final String? authToken = await authManager.getAuthToken();
  runApp(MyApp(authToken: authToken));
}

class MyApp extends StatelessWidget {
  final String? authToken;
  const MyApp({super.key, this.authToken});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {    
    return MaterialApp(      
      debugShowCheckedModeBanner: false,
      // home: const SplashScreen(),
      home: authToken == null ? const SplashScreen() : const Dashboard(),
      theme: _buildTheme(Brightness.light),
      routes: {
        '/welcome': (context) => const HomePage(),
        '/customerhome': (context) => const CustomerHome(),
      },
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
  );  
}
