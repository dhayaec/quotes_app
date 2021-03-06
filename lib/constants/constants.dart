import 'dart:math';

import 'package:flutter/material.dart';

String appName = 'Quotes App';

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
  'Marck Script',
  'Markazi Text',
  'Norican',
  'Pacifico',
  'Shadows Into Light'
];

List shuffleList(List items) {
  var random = new Random();

  // Go through all elements.
  for (var i = items.length - 1; i > 0; i--) {
    // Pick a pseudorandom number according to the list length
    var n = random.nextInt(i + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}

const FAVORITES_LIST_KEY = 'favorites';

var appTheme = ThemeData(
    primarySwatch: Colors.blueGrey, canvasColor: Colors.black.withOpacity(0.4));
