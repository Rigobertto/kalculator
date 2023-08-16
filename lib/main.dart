import 'package:flutter/material.dart';
import 'package:kalculator/screens/time_calculator_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimeCalculatorScreen(), // Use a tela principal aqui
    );
  }
}


