import 'package:flutter/material.dart';

class BlankPage extends StatefulWidget {
  const BlankPage({Key? key}) : super(key: key);

  @override
  _BlankPageState createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  List<int> a = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                print('now');
                setState(
                  () {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final int item = a.removeAt(oldIndex);
                    a.insert(newIndex, item);
                  },
                );
              },
              children: a.map((index) {
                return ExpansionTile(
                  key: Key('$index'),
                  title: Text('Tile' + '${index.toString()}'),
                  children: <Widget>[
                    Container(
                      height: 100,
                      child: ListView(children: <Widget>[
                        InkWell(
                          child: Text("This is a test"),
                          onTap: () => print("hello"),
                        ),
                        Text('This is a test' + '$index'),
                      ]),
                    )
                  ],
                );
              }).toList()),
        ),
      ),
    );
  }
}
