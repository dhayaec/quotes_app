import 'package:flutter/material.dart';
import 'package:quotes_app/constants/constants.dart';
import 'package:quotes_app/pages/FavoriteQuotes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToolButtons extends StatelessWidget {
  const ToolButtons({
    Key key,
    @required int itemNumber,
    @required int quotesCount,
    @required this.myData,
    @required this.bgColor,
  })  : _itemNumber = itemNumber,
        _quotesCount = quotesCount,
        super(key: key);

  final int _itemNumber;
  final int _quotesCount;
  final dynamic myData;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () async {
              var prefs = await SharedPreferences.getInstance();
              var favorites = prefs.getStringList(FAVORITES_LIST_KEY);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                        quotes: myData,
                        favorites: favorites,
                        bgColor: bgColor,
                      ),
                ),
              );
            },
            icon: Icon(Icons.menu),
            color: Colors.white,
          ),
          Row(
            children: <Widget>[
              Text(
                "$_itemNumber / $_quotesCount",
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
    );
  }
}
