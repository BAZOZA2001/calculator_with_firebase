import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculator_app/services/auth_service.dart';
import 'package:calculator_app/screens/calculator_screen.dart';
import 'package:calculator_app/screens/sign_in_screen.dart';
import 'package:calculator_app/screens/sign_up_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData.dark(),
      home: SignInScreen(), // Removed const here
      routes: {
        '/signin': (_) => SignInScreen(), // Removed const here
        '/signup': (_) => SignUpScreen(), // Removed const here
        '/calculator': (_) => CalculatorScreen(), // Removed const here
      },
    );
  }
}
