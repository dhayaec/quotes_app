import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu(
      {Key key, @required PageController pageController, @required this.myData})
      : _pageController = pageController,
        super(key: key);

  final PageController _pageController;
  final dynamic myData;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(
              Icons.favorite,
              size: 40.0,
            ),
            onPressed: () {},
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(
              Icons.arrow_upward,
              size: 40.0,
            ),
            onPressed: () {
              _pageController.animateToPage(0,
                  duration: Duration(milliseconds: 250), curve: SawTooth(3));
            },
          ),
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                color: Colors.white,
                icon: Icon(
                  Icons.share,
                  size: 40.0,
                ),
                onPressed: () {
                  final snackBar = SnackBar(
                    content: Text('Loading available apps to share'),
                    duration: Duration(seconds: 2),
                  );
                  var page = _pageController.page.toInt();
                  var quoteText = myData[page]['quoteText'];
                  var quoteAuthor = myData[page]['quoteAuthor'];
                  Share.share(quoteText + '  --  ' + quoteAuthor);
                  Scaffold.of(context).showSnackBar(snackBar);
                  // this.takeScreenShot();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // takeScreenShot() async {
  //   RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
  //   var image = await boundary.toImage();
  //   var byteData = await image.toByteData(format: ImageByteFormat.png);
  //   var pngBytes = byteData.buffer.asUint8List();
  //   var img = base64Encode(pngBytes);
  //   // print(img);
  //   print(pngBytes);
  //   final directory = await getApplicationDocumentsDirectory();
  //   final path = directory.path;
  //   File imgFile = new File('$path/screenshot.png');
  //   var file = imgFile.writeAsBytes(pngBytes);
  //   print(file.toString());
  // }
}
