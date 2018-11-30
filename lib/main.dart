import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:quotes_app/BottomMenu.dart';
import 'package:quotes_app/Page.dart';
import 'package:quotes_app/QuotesDrawer.dart';
import 'package:quotes_app/constants.dart';

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

class PageViewExample extends StatefulWidget {
  @override
  PageViewExampleState createState() {
    return new PageViewExampleState();
  }
}

class PageViewExampleState extends State<PageViewExample> {
  final PageController _pageController = PageController();
  int _itemNumber = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: QuotesDrawer(
          pageController: _pageController,
        ),
        body: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/json/quotes.json'),
            builder: (context, snapshot) {
              var myData = json.decode(snapshot.data.toString());
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  PageView.builder(
                    onPageChanged: (index) {
                      setState(() async {
                        _itemNumber = index + 1;
                        var bgColor = colorList[index % colorList.length];
                        await FlutterStatusbarcolor.setNavigationBarColor(
                            bgColor);
                      });
                    },
                    itemCount: myData == null ? 0 : myData.length,
                    scrollDirection: Axis.vertical,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      var quoteText = myData[index]['quoteText'];
                      var quoteAuthor = myData[index]['quoteAuthor'];
                      double width = MediaQuery.of(context).size.width - 30.0;
                      double height = MediaQuery.of(context).size.height / 1.5;
                      Color bgColor = colorList[index % colorList.length];

                      return new Page(
                          index: index,
                          bgColor: bgColor,
                          width: width,
                          height: height,
                          quoteText: quoteText,
                          quoteAuthor: quoteAuthor);
                    },
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 30.0),
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
                            Text(
                              "$_itemNumber / ${myData.length}",
                              style: TextStyle(color: Colors.white),
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
                  new BottomMenu(
                      pageController: _pageController, myData: myData),
                ],
              );
            }));
  }
}
