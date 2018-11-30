import 'package:flutter/material.dart';
import 'package:share/share.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({
    Key key,
    @required PageController pageController,
    @required this.myData,
  })  : _pageController = pageController,
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
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
