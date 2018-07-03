import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String _appName = 'QuotesApp';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appName,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
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
    return new Container(
      color: color,
      child: new Center(child: new Text(pageName)),
    );
  }
}

List<Color> colorList = [
  Colors.blue,
  Colors.lightGreen,
  Colors.orange,
  Colors.deepPurple,
  Colors.lime,
  Colors.red,
  Colors.pink
];

class PageViewExample extends StatelessWidget {
  final controllder = PageController(initialPage: 0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      endDrawer: _buildDrawer(context),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PageView.builder(
            itemCount: 999,
            scrollDirection: Axis.vertical,
            controller: controllder,
            itemBuilder: (context, index) {
              return Page(colorList[index % colorList.length], 'Page $index');
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
                        icon: Icon(Icons.settings),
                        onPressed: () => Scaffold.of(context).openDrawer());
                  },
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      color: Colors.pink,
                      icon: Icon(Icons.favorite),
                      onPressed: () {},
                    ),
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.share),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('one'),
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Text('one'),
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Text('Top'),
                  onPressed: () {
                    controllder.animateToPage(0,
                        duration: Duration(seconds: 1),
                        curve: ElasticInOutCurve());
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
