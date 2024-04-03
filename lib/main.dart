import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/customer/customer_home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {    
    return MaterialApp(      
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: _buildTheme(Brightness.light),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
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
