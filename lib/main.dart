import 'dart:convert';
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
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.orange,
  Colors.indigo,
  Colors.deepPurple,
  Colors.lightBlueAccent,
  Colors.pinkAccent
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
  'Shadows Into Light',
  'Shrikhand',
];

class PageViewExample extends StatelessWidget {
  final controllder = PageController(initialPage: 0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context, count: 100),
      endDrawer: _buildDrawer(context),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FutureBuilder(
            future: DefaultAssetBundle
                .of(context)
                .loadString('assets/json/quotes.json'),
            builder: (context, snapshot) {
              var myData = json.decode(snapshot.data.toString());
              return PageView.builder(
                itemCount: myData == null ? 0 : myData.length,
                scrollDirection: Axis.vertical,
                controller: controllder,
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
                        Text(
                          quoteText,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: fontFamily[index % fontFamily.length],
                              fontSize: 50.0),
                        ),
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
              );
            },
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: const Color(0x30000000),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.menu),
                          onPressed: () => {}),
                    );
                  },
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                    Builder(builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: const Color(0x30000000),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.format_list_bulleted),
                          onPressed: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                        ),
                      );
                    })
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
                    controllder.animateToPage(0,
                        duration: Duration(seconds: 1),
                        curve: ElasticInOutCurve());
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
                        Share.share('check out my app QuotesApp');
                        Scaffold.of(context).showSnackBar(snackBar);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, {int count = 20}) {
    final items = List<String>.generate(count, (i) => "Menu Option ${i+1}");

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
              onTap: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }
}
