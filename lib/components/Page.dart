import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quotes_app/components/AppName.dart';
import 'package:quotes_app/constants/constants.dart';

class Page extends StatelessWidget {
  const Page({
    Key key,
    @required this.index,
    @required this.bgColor,
    @required this.width,
    @required this.height,
    @required this.quoteText,
    @required this.quoteAuthor,
  }) : super(key: key);

  final Color bgColor;
  final double width;
  final double height;
  final String quoteText;
  final String quoteAuthor;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 80.0),
      color: bgColor,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: width,
              height: height,
              child: AutoSizeText(quoteText,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: fontFamily[index % fontFamily.length],
                  ),
                  minFontSize: 10.0,
                  presetFontSizes: [
                    70.0,
                    60.0,
                    50.0,
                    40.0,
                    30.0,
                  ]),
            ),
          ),
          Text(
            quoteAuthor,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: AppName(),
          )
        ],
      ),
    );
  }
}
