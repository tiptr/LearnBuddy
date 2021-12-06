import 'package:flutter/material.dart';

// For showing pages when clicking on menu items, check this URL.
// https://stackoverflow.com/questions/54622602/how-to-use-a-bottomappbar-for-navigation-in-flutter?rq=1

class BarMenu extends StatelessWidget {
  const BarMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 75,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _menuItem(
              const EdgeInsets.only(left: 20.0),
              const Icon(Icons.timer_outlined),
              "Timer",
            ),
            _menuItem(
              const EdgeInsets.only(right: 25.0),
              const Icon(Icons.document_scanner_outlined),
              "Aufgaben",
            ),
            _menuItem(
              const EdgeInsets.only(left: 25.0),
              const Icon(Icons.beach_access_outlined),
              "Ausgleich",
            ),
            _menuItem(
              const EdgeInsets.only(right: 20.0),
              const Icon(Icons.book_outlined),
              "Lernhilfen",
            ),
          ],
        ),
      ),
    );
  }

  Container _menuItem(EdgeInsetsGeometry padding, Icon icon, String label) {
    return Container(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 30.0,
              icon: icon,
              onPressed: () {},
            ),
            Text(label),
          ],
        ));
  }
}
