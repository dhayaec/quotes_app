import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:quotes_app/components/BottomMenu.dart';
import 'package:quotes_app/components/Page.dart';
import 'package:quotes_app/components/QuotesDrawer.dart';
import 'package:quotes_app/components/ToolButtons.dart';
import 'package:quotes_app/constants/constants.dart';

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
    return PageViewExampleState();
  }
}

class PageViewExampleState extends State<PageViewExample> {
  final PageController _pageController = PageController();
  int _itemNumber = 1;
  int _quotesCount = 0;
  bool shuffle = false;
  GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();
  @override
  initState() {
    super.initState();
    FlutterStatusbarcolor.setNavigationBarColor(colorList[0]);
  }

  void _shuffleList() {
    setState(() {
      shuffle = !shuffle;
    });
  }

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
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                var quotesList;
                List data = json.decode(snapshot.data.toString());
                if (shuffle) {
                  quotesList = shuffleList(data);
                } else {
                  quotesList = data;
                }
                _quotesCount = quotesList.length;
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    RepaintBoundary(
                      key: globalKey,
                      child: PageView.builder(
                        onPageChanged: (index) {
                          setState(() {
                            _itemNumber = index + 1;
                            var bgColor = colorList[index % colorList.length];
                            FlutterStatusbarcolor.setNavigationBarColor(
                                bgColor);
                          });
                        },
                        itemCount: quotesList == null ? 0 : quotesList.length,
                        scrollDirection: Axis.vertical,
                        controller: _pageController,
                        itemBuilder: (context, index) {
                          var quoteText = quotesList[index]['quoteText'];
                          var quoteAuthor = quotesList[index]['quoteAuthor'];
                          double width =
                              MediaQuery.of(context).size.width - 30.0;
                          double height =
                              MediaQuery.of(context).size.height / 1.5;
                          Color bgColor = colorList[index % colorList.length];
                          return Page(
                              index: index,
                              bgColor: bgColor,
                              width: width,
                              height: height,
                              quoteText: quoteText,
                              quoteAuthor: quoteAuthor);
                        },
                      ),
                    ),
                    ToolButtons(
                        itemNumber: _itemNumber, quotesCount: _quotesCount),
                    BottomMenu(
                        pageController: _pageController,
                        myData: quotesList,
                        globalKey: globalKey,
                        shuffleList: _shuffleList,
                        shuffleState: shuffle),
                  ],
                );
              }
            }));
  }
}
