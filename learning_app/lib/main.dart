import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/todo/bloc/todos_cubit.dart';
import 'package:learning_app/todo/screens/todos_screen.dart';

const List<Widget> _pages = <Widget>[
  Text("Page Timer not implemented yet"),
  TodosScreen(),
  Text("Page Dashboard not implemented yet"),
  Text("Page Ausgleich not implemented yet"),
  Text("Page Lernhilfen not implemented yet"),
];

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TodosCubit>(
          create: (context) => TodosCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lernbuddy',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lernbuddy"),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _navBar(context),
    );
  }

  BottomNavigationBar _navBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        _navItem(Icons.timer, "Timer"),
        _navItem(Icons.document_scanner_outlined, "Aufgaben"),
        _navItem(Icons.home_outlined, "Dashboard"),
        _navItem(Icons.beach_access_outlined, "Ausgleich"),
        _navItem(Icons.book_outlined, "Lernhilfen"),
      ],
    );
  }

  BottomNavigationBarItem _navItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
