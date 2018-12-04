import 'package:flutter/material.dart';

String appName = 'Quotes App';

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

List<Color> colorList = [
  Colors.blue[900],
  Colors.cyan[900],
  Colors.lightBlue[900],
  Colors.green[900],
  Colors.deepOrange[900],
  Colors.teal[900],
  Colors.yellow[900],
  Colors.lightGreen[900],
  Colors.lime[900],
  Colors.orange[900],
  Colors.amber[900],
  Colors.pink[900],
  Colors.deepPurple[900],
  Colors.red[900],
  Colors.indigo[900],
  Colors.purple[900],
];

List<String> fontFamily = [
  'Bad Script',
  'Chela One',
  'Dancing Script',
  'Gabriela',
  'Gaegu',
  'Handlee',
  'Knewave',
  'Marck Script',
  'Markazi Text',
  'Norican',
  'Pacifico',
  'Shadows Into Light'
];
