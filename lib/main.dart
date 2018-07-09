import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String _appName = 'QuotesApp';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appName,
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          canvasColor: Colors.black.withOpacity(0.4)),
      home: PageViewExample(),
    );
  }
}

class Page extends StatelessWidget {
  final color;
  final quoteText;
  final fontFamily;
  final authorName;

  Page(this.color, this.fontFamily, this.quoteText, this.authorName);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: color,
      child: Center(
          child: Container(
        child: Column(
          children: <Widget>[
            Text(
              quoteText,
              style: TextStyle(
                  fontSize: 30.0, color: Colors.white, fontFamily: fontFamily),
            ),
            Text(authorName)
          ],
        ),
      )),
    );
  }
}

List<Color> colorList = [
  Colors.blue[900],
  Colors.cyan[900],
  Colors.lightBlue[900],
  Colors.green[900],
  Colors.teal[900],
  Colors.yellow[900],
  Colors.lightGreen[900],
  Colors.lime[900],
  Colors.orange[900],
  Colors.amber[900],
  Colors.pink[900],
  Colors.deepOrange[900],
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

class PageViewExample extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildDrawer(context, count: 100),
        endDrawer: _buildDrawer(context),
        body: FutureBuilder(
            future: DefaultAssetBundle
                .of(context)
                .loadString('assets/json/quotes.json'),
            builder: (context, snapshot) {
              var myData = json.decode(snapshot.data.toString());
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  PageView.builder(
                    itemCount: myData == null ? 0 : myData.length,
                    scrollDirection: Axis.vertical,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      var quoteText = myData[index]['quoteText'];
                      var quoteAuthor = myData[index]['quoteAuthor'];
                      double height = MediaQuery.of(context).size.height;
                      return Container(
                        padding: EdgeInsets.only(
                            top: height / 6, left: 20.0, right: 20.0),
                        color: colorList[index % colorList.length],
                        child: Column(
                          children: <Widget>[
                            LayoutBuilder(builder: (context, constraint) {
                              var fontSizeFactor = min(
                                          constraint.biggest.height,
                                          constraint.biggest.width) /
                                      quoteText.length +
                                  36;
                              return Text(
                                quoteText,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily:
                                        fontFamily[index % fontFamily.length],
                                    fontSize: fontSizeFactor),
                              );
                            }),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                quoteAuthor,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 30.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'Quotes App',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Chela One',
                                fontSize: 30.0),
                          ),
                          onPressed: () {},
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.info),
                              onPressed: () {},
                            ),
                            Builder(
                              builder: (BuildContext context) {
                                return IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.format_list_bulleted),
                                  onPressed: () {
                                    Scaffold.of(context).openEndDrawer();
                                  },
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
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
                                duration: Duration(milliseconds: 250),
                                curve: SawTooth(3));
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
                                  content:
                                      Text('Loading available apps to share'),
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
                  ),
                ],
              );
            }));
  }

  Widget _buildDrawer(BuildContext context, {int count = 82}) {
    final items = List<String>.generate(count, (i) => "Chapter ${i+1}");

    return Drawer(
      elevation: 0.0,
      child: Container(
        padding: EdgeInsets.only(top: 22.0),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                '${items[index]}',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                Navigator.pop(context);
                var page = index * 20;
                // _pageController.jumpToPage(page);
                _pageController.animateToPage(page,
                    duration: Duration(milliseconds: 250), curve: SawTooth(3));
              },
            );
          },
        ),
      ),
    );
  }
}
