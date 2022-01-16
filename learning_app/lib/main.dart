import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/categories/bloc/categories_cubit.dart';
import 'package:learning_app/features/keywords/bloc/keywords_cubit.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/screens/learn_lists_screen.dart';
import 'package:learning_app/features/leisure/screens/leisure_screen.dart';
import 'package:learning_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:learning_app/features/tasks/bloc/add_task_cubit.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/screens/task_screen.dart';
import 'package:learning_app/features/timer/screens/timer_screen.dart';
import 'package:learning_app/util/injection.dart';
import 'package:logger/logger.dart';

import 'constants/theme_color_constants.dart';
import 'constants/theme_font_constants.dart';

const List<Widget> _pages = <Widget>[
  TimerScreen(),
  TaskScreen(),
  DashboardScreen(),
  LeisureScreen(),
  LearningAidsScreen(),
];

void main() {
  // Initialize dependency injection:
  configureDependencies();

  Logger.level = Level.debug;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TasksCubit>(
          lazy: true,
          create: (context) {
            var cubit = TasksCubit();
            // Loading tasks initially is probably a good idea
            // since many features depend on the tasks.

            // Loading is acync., but will not take long anyways thanks to
            // dynamic loading (only the first X tasks are being loaded)
            cubit.loadTasks();
            return cubit;
          },
        ),
        BlocProvider<AddTaskCubit>(
          lazy: true,
          create: (context) {
            return AddTaskCubit();
          },
        ),
        BlocProvider<CategoriesCubit>(
          lazy: true,
          create: (context) {
            var cubit = CategoriesCubit();
            cubit.loadCategories();
            return cubit;
          },
        ),
        BlocProvider<KeyWordsCubit>(
          lazy: true,
          create: (context) {
            var cubit = KeyWordsCubit();
            cubit.loadKeyWords();
            return cubit;
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
    final ThemeData theme = ThemeData();
    // Must be declared explicitly to be passed on to the TextTheme, which relies
    // on the colorScheme
    final ColorScheme colorScheme = ColorSchemes.defaultColorScheme();
    final TextTheme textTheme = TextThemes.defaultTextTheme(colorScheme);
    return MaterialApp(
      title: 'Lernbuddy',
      theme: theme.copyWith(
        colorScheme: colorScheme,
        scrollbarTheme: ScrollbarThemeData(
          isAlwaysShown: false,
          thickness: MaterialStateProperty.all(10),
          radius: const Radius.circular(10),
          minThumbLength: 50,
        ),
        textTheme: textTheme,

        // necessary for native Components like DatePicker or DurationPicker:
        // Date and Durationpicker background
        dialogBackgroundColor: colorScheme.cardColor,
        // ColorPicker hex-textfield label
        hintColor: colorScheme.onBackgroundSoft,
        // DurationPicker innercircle color
        canvasColor: colorScheme.cardColor,
        // DurationPicker thick circle border
        backgroundColor: colorScheme.tertiary,
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
    return SafeArea(
      child: Scaffold(
        // TODO: think about changing to something like lazy_load_indexed_stack
        // (separate package), so that not every page has to be loaded at startup
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: _navBar(context),
      ),
    );
  }

  BottomNavigationBar _navBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      unselectedItemColor: Theme.of(context).colorScheme.onBackgroundSoft,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      backgroundColor: Theme.of(context).colorScheme.cardColor,
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
