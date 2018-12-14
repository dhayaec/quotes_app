import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:quotes_app/pages/QuotesScreen.dart';

class FavoritesScreen extends StatefulWidget {
  final List<String> favorites;
  final List<dynamic> quotes;
  final Color bgColor;

  FavoritesScreen({
    Key key,
    @required this.favorites,
    @required this.quotes,
    @required this.bgColor,
  }) : super(key: key);

  @override
  FavoritesScreenState createState() {
    return new FavoritesScreenState();
  }
}

class FavoritesScreenState extends State<FavoritesScreen> {
  var _favQuotes = List<dynamic>();

  @override
  void initState() {
    super.initState();
    FlutterStatusbarcolor.setNavigationBarColor(Colors.transparent);
    setState(() {
      _favQuotes = this
          .widget
          .favorites
          .map((item) => this.widget.quotes[int.parse(item) - 1])
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
          backgroundColor: this.widget.bgColor,
        ),
        body: Container(
          color: Colors.white,
          child: _favQuotes.length == 0
              ? ListView(
                  children: <Widget>[
                    ListTile(title: Text('No favorite quotes added!'))
                  ],
                )
              : ListView.builder(
                  itemCount: _favQuotes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(_favQuotes[index]['quoteText']),
                      subtitle: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(" -- " + _favQuotes[index]['quoteAuthor']),
                      ),
                      onTap: () {
                        var quoteId = int.parse(this.widget.favorites[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                QuotesScreen(initialPage: quoteId - 1),
                          ),
                        );
                        print('object');
                        print(quoteId);
                      },
                    );
                  },
                ),
        ));
  }
}
