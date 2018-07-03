import 'dart:ui';

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
          canvasColor: Colors.white.withOpacity(0.1)),
      home: PageViewExample(),
    );
  }
}

class Page extends StatelessWidget {
  final color;
  final pageName;

  Page(this.color, this.pageName);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: color,
      child: Center(
          child: Text(
        pageName,
        style: TextStyle(fontSize: 30.0, color: Colors.white),
      )),
    );
  }
}

List<Color> colorList = [
  Colors.blue,
  Colors.lightGreen,
  Colors.orange,
  Colors.indigo,
  Colors.deepPurple,
  Colors.red,
  Colors.pink
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
          PageView.builder(
            itemCount: 999,
            scrollDirection: Axis.vertical,
            controller: controllder,
            itemBuilder: (context, index) {
              return Page(colorList[index % colorList.length],
                  'Welcome to my website this is an example $index');
            },
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openDrawer());
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
                      return IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.format_list_bulleted),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
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
    final items = List<String>.generate(count, (i) => "Item $i");

    return Drawer(
      elevation: 0.0,
      child: BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          margin: EdgeInsets.only(top: 20.0),
          decoration: new BoxDecoration(color: Colors.transparent),
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
      ),
    );
  }
}
