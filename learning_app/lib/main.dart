import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/categories/bloc/categories_cubit.dart';
import 'package:learning_app/features/keywords/bloc/keywords_cubit.dart';
import 'package:learning_app/features/leisure/screens/leisure_screen.dart';
import 'package:learning_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:learning_app/features/tasks/bloc/alter_task_cubit.dart';
import 'package:learning_app/features/task_queue/bloc/task_queue_bloc.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/screens/task_list_screen.dart';
import 'package:learning_app/features/timer/screens/timer_screen.dart';
import 'package:learning_app/util/animated_indexed_stack.dart';
import 'package:learning_app/util/injection.dart';
import 'package:learning_app/features/learning_aids/screens/learning_aids_screen.dart';
import 'package:learning_app/util/nav_cubit.dart';
import 'package:logger/logger.dart';
import 'package:learning_app/features/time_logs/bloc/time_logging_bloc.dart';

import 'constants/theme_constants.dart';

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
        BlocProvider<NavCubit>(
          lazy: false,
          create: (context) => NavCubit(),
        ),
        BlocProvider<TasksCubit>(
          lazy: true,
          create: (context) {
            var cubit = TasksCubit();
            // Loading tasks initially is probably a good idea
            // since many features depend on the tasks.

            // Loading is async., but will not take long anyways thanks to
            // dynamic loading (only the first X tasks are being loaded)
            cubit.loadTasks();
            return cubit;
          },
        ),
        BlocProvider<TimeLoggingBloc>(
          create: (context) {
            return TimeLoggingBloc();
          },
        ),
        BlocProvider<AlterTaskCubit>(
          lazy: true,
          create: (context) {
            return AlterTaskCubit();
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
        BlocProvider(
          create: (context) => TaskQueueBloc(),
        ),
        BlocProvider<KeyWordsCubit>(
          lazy: true,
          create: (context) {
            var cubit = KeyWordsCubit();
            cubit.loadKeyWords();
            return cubit;
          },
        ),
        BlocProvider<TaskQueueBloc>(
          lazy: true,
          create: (context) {
            var bloc = TaskQueueBloc();
            bloc.add(InitQueueEvent());
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
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'Lernbuddy',
      theme: theme.copyWith(
        colorScheme: ColorSchemes.defaultColorScheme(),
        scrollbarTheme: ScrollbarThemeData(
          isAlwaysShown: false,
          thickness: MaterialStateProperty.all(10),
          radius: const Radius.circular(10),
          minThumbLength: 50,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      BlocProvider.of<NavCubit>(context).navigateTo(index);
    }

    return BlocBuilder<NavCubit, int>(builder: (context, selectedIndex) {
      return SafeArea(
        child: Scaffold(
          body: AnimatedIndexedStack(
            index: selectedIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: onItemTapped,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: "Timer",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner_outlined),
                label: "Aufgaben",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.beach_access_outlined),
                label: "Ausgleich",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined),
                label: "Lernhilfen",
              ),
            ],
          ),
        ),
      );
    });
  }
}
