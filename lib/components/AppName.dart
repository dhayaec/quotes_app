import 'package:flutter/material.dart';
import 'package:quotes_app/constants/constants.dart';

class AppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      appName,
      style: TextStyle(
          color: Colors.white, fontFamily: 'Chela One', fontSize: 30.0),
    );
  }
}
