import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:learning_app/features/ausgleich/screens/ausgleich_screen.dart';
import 'package:learning_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:learning_app/features/tasks/bloc/task_cubit.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/features/tasks/screens/task_screen.dart';
import 'package:learning_app/services/time_logging/bloc/time_logging_bloc.dart';
import 'package:learning_app/services/time_logging/models/time_logging_object.dart';
import 'package:learning_app/services/time_logging/repository/time_logging_repository.dart';
import 'package:logger/logger.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/lernhilfen/screens/lernhilfen_screen.dart';
import 'features/timer/screens/timer_screen.dart';

const List<Widget> _pages = <Widget>[
  TimerScreen(),
  TaskScreen(),
  DashboardScreen(),
  AusgleichScreen(),
  LernhilfenScreen(),
];

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TimeLoggingObjectAdapter());
  Logger.level = Level.debug;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TaskCubit>(
          create: (context) {
            var cubit = TaskCubit(TaskRepository());

            // Loading tasks initially is probably a good idea
            // since many features depend on the tasks.
            cubit.loadTasks();
            return cubit;
          },
          
        ),
        BlocProvider<TimeLoggingBloc>(
          create: (context) {
            var bloc = TimeLoggingBloc(TimeLoggingRepository());
            return bloc;
          },
          
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
        primarySwatch: null,
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
  // The Dashboard is at index 2 in the _pages-List
  int _selectedIndex = 2;

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
