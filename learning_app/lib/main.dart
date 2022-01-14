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
import 'package:learning_app/util/logger.dart';
import 'package:logger/logger.dart';

class RouteWidget {
  final String route;
  final Widget widget;

  const RouteWidget({required this.route, required this.widget});
}

const List<RouteWidget> _routeWidgets = [
  RouteWidget(widget: TimerScreen(), route: '/timer'),
  RouteWidget(widget: TaskScreen(), route: '/tasks'),
  RouteWidget(widget: DashboardScreen(), route: '/'),
  RouteWidget(widget: LeisureScreen(), route: '/leisure'),
  RouteWidget(widget: LearningAidsScreen(), route: '/learningaids'),
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

    return MaterialApp(
      title: 'Lernbuddy',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: const Color(0xFF3444CF),
          secondary: const Color(0xFF9E5EE1),
        ),
        scrollbarTheme: ScrollbarThemeData(
          isAlwaysShown: false,
          thickness: MaterialStateProperty.all(10),
          radius: const Radius.circular(10),
          minThumbLength: 50,
        ),
      ),
      initialRoute: '/',
      home: const Content(),
    );
  }
}

class Content extends StatefulWidget {
  const Content({Key? key}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  // The Dashboard is at index 2 in the _routeWidgets-List
  int _selectedIndex = 2;
  final navigatorKey = GlobalKey<NavigatorState>();

  void _onItemTapped(
    int index,
  ) {
    navigatorKey.currentState?.pushNamed(_routeWidgets[index].route);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            // Manage your route names here

            var index = _routeWidgets.indexWhere(
                (routeWidget) => routeWidget.route == settings.name);

            if (index >= 0) {
              builder = (BuildContext context) => _routeWidgets[index].widget;
            } else {
              throw Exception("Unknown route");
            }

            // Important if condition to prevent Flutter from infinite render cycles
            if (_selectedIndex != index) {
              setState(() {
                logger.d("Page $index selected.");
                _selectedIndex = index;
              });
            }

            // You can also return a PageRouteBuilder and
            // define custom transitions between pages
            return MaterialPageRoute(
              builder: builder,
              settings: settings,
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
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
  }
}
