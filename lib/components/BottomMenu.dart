import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/services.dart' show ByteData, MethodChannel;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu(
      {Key key,
      @required PageController pageController,
      @required this.myData,
      @required this.globalKey})
      : _pageController = pageController,
        super(key: key);

  final PageController _pageController;
  final dynamic myData;
  final GlobalKey<State<StatefulWidget>> globalKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: 20.0),
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
                  duration: Duration(milliseconds: 450), curve: SawTooth(3));
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
                  Scaffold.of(context).showSnackBar(snackBar);
                  _captureAndSharePng();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          this.globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      print('${tempDir.path}/image.png');
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:dev.dhaya.share/share');
      channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }
}
