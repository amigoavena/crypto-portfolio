import 'package:flutter/material.dart';
import 'package:portfolio_litium/app/locator.dart';
import 'package:portfolio_litium/views/portfolio_screen.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moola X',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: PortfolioScreen(),
    );
  }
}