import 'package:flutter/material.dart';
import 'package:quotes_app/constants/constants.dart';
import 'package:quotes_app/pages/QuotesScreen.dart';

void main() => runApp(QuotesApp());

class QuotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: appTheme,
      home: QuotesScreen(),
    );
  }
}
