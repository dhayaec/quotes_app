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
    return Container(
      color: color,
      child: Center(child: Text(pageName)),
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
                IconButton(
                  color: Colors.white,
                  icon: Icon(
                    Icons.share,
                    size: 40.0,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: DrawerHeader(
                child: CircleAvatar(
              child: Icon(Icons.account_balance),
            )),
            color: Colors.tealAccent,
          ),
          Container(
            color: Colors.orange,
            child: ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            color: Colors.orange,
            child: ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
