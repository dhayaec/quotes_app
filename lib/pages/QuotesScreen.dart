import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:quotes_app/components/BottomMenu.dart';
import 'package:quotes_app/components/Page.dart';
import 'package:quotes_app/components/QuotesDrawer.dart';
import 'package:quotes_app/components/ToolButtons.dart';
import 'package:quotes_app/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuotesScreen extends StatefulWidget {
  final int initialPage;

  QuotesScreen({
    Key key,
    this.initialPage = 0,
  }) : super(key: key);

  @override
  QuotesScreenState createState() {
    return QuotesScreenState();
  }
}

class QuotesScreenState extends State<QuotesScreen> {
  PageController _pageCtrl;
  int _itemNumber = 1;
  int _quotesCount = 0;
  bool _isFav = false;
  var _quotesList = List<dynamic>();
  var _bgColor = colorList[0];

  GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();
  var sp = SharedPreferences.getInstance();

  @override
  initState() {
    super.initState();
    _pageCtrl = PageController(initialPage: this.widget.initialPage);
    setState(() {
      _isFav = true;
      _bgColor = _getColor(this.widget.initialPage);
    });
    FlutterStatusbarcolor.setNavigationBarColor(_bgColor);
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _addToFavorites(int index) async {
    var itemNumber = index.toString();
    var prefs = await sp;
    // prefs.clear();
    var favs = prefs.getStringList(FAVORITES_LIST_KEY) ?? List<String>();
    if (!favs.contains(itemNumber)) {
      favs.add(itemNumber);
      prefs.setStringList(FAVORITES_LIST_KEY, favs);
      setState(() {
        _isFav = true;
      });
    } else {
      favs.remove(itemNumber);
      prefs.setStringList(FAVORITES_LIST_KEY, favs);
      setState(() {
        _isFav = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: QuotesDrawer(
          pageController: _pageCtrl,
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
                _quotesList = json.decode(snapshot.data.toString());
                _quotesCount = _quotesList.length;
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    RepaintBoundary(
                      key: globalKey,
                      child: PageView.builder(
                        onPageChanged: (index) async {
                          var prefs = await sp;
                          var favList = prefs.getStringList(FAVORITES_LIST_KEY);
                          setState(() {
                            _itemNumber = index + 1;
                            _bgColor = _getColor(index);
                            if (favList.contains((index + 1).toString())) {
                              _isFav = true;
                            } else {
                              _isFav = false;
                            }
                            FlutterStatusbarcolor.setNavigationBarColor(
                                _bgColor);
                          });
                        },
                        itemCount: _quotesList == null ? 0 : _quotesList.length,
                        scrollDirection: Axis.vertical,
                        controller: _pageCtrl,
                        itemBuilder: (context, index) {
                          var size = MediaQuery.of(context).size;
                          double width = size.width;
                          double radio = size.height / size.width;
                          double height = radio < 1.7
                              ? size.height / 2
                              : size.height / radio;

                          var quoteText = _quotesList[index]['quoteText'];
                          var quoteAuthor = _quotesList[index]['quoteAuthor'];

                          return Page(
                              index: index,
                              bgColor: _bgColor,
                              width: width,
                              height: height,
                              quoteText: quoteText,
                              quoteAuthor: quoteAuthor);
                        },
                      ),
                    ),
                    ToolButtons(
                      itemNumber: _itemNumber,
                      quotesCount: _quotesCount,
                      myData: _quotesList,
                      bgColor: _bgColor,
                    ),
                    BottomMenu(
                      pageController: _pageCtrl,
                      myData: _quotesList,
                      globalKey: globalKey,
                      index: _itemNumber,
                      addToFavorites: _addToFavorites,
                      isFav: _isFav,
                    ),
                  ],
                );
              }
            }));
  }

  Color _getColor(int index) => colorList[index % colorList.length];
}
