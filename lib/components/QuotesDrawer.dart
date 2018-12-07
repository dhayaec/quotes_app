import 'package:flutter/material.dart';

class QuotesDrawer extends StatelessWidget {
  final PageController pageController;

  QuotesDrawer({@required this.pageController});
  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(82, (i) => "Jump to List No. ${i + 1}");
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
              onTap: () async {
                Navigator.pop(context);
                var page = index * 20;
                // _pageController.jumpToPage(page);
                pageController.animateToPage(page,
                    duration: Duration(milliseconds: 250), curve: SawTooth(3));
              },
            );
          },
        ),
      ),
    );
  }
}
