import 'package:flutter/material.dart';

class ToolButtons extends StatelessWidget {
  const ToolButtons({
    Key key,
    @required int itemNumber,
    @required int quotesCount,
  })  : _itemNumber = itemNumber,
        _quotesCount = quotesCount,
        super(key: key);

  final int _itemNumber;
  final int _quotesCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {},
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
