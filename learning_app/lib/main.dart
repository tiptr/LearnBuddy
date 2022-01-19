import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/settings_constants.dart';
import 'package:learning_app/features/categories/bloc/categories_cubit.dart';
import 'package:learning_app/features/keywords/bloc/keywords_cubit.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/screens/learn_lists_screen.dart';
import 'package:learning_app/features/leisure/bloc/leisure_cubit.dart';
import 'package:learning_app/features/leisure/bloc/suggested_leisure_cubit.dart';
import 'package:learning_app/features/leisure/screens/leisure_screen.dart';
import 'package:learning_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:learning_app/features/task_queue/bloc/task_queue_bloc.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/screens/task_list_screen.dart';
import 'package:learning_app/features/timer/screens/timer_screen.dart';
import 'package:learning_app/shared/shared_preferences_data.dart';
import 'package:learning_app/util/injection.dart';
import 'package:learning_app/util/nav_cubit.dart';
import 'package:learning_app/util/notification_api.dart';
import 'package:logger/logger.dart';
import 'package:learning_app/features/time_logs/bloc/time_logging_bloc.dart';
import 'features/learn_lists/learn_lists_general/screens/learn_lists_screen.dart';
import 'constants/theme_color_constants.dart';
import 'features/themes/bloc/bloc.dart';
import 'features/themes/themes.dart';

const List<Widget> _pages = <Widget>[
  TimerScreen(),
  TaskScreen(),
  DashboardScreen(),
  LeisureScreen(),
  LearnListsScreen(),
];

Future<void> main() async {
  // Initialize dependency injection:
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesData.init();
  ThemeName themeName = SharedPreferencesData.themeName ?? defaultThemeName;
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
            cubit.loadTasksWithoutFilter();
            return cubit;
          },
        ),
        BlocProvider<TimeLoggingBloc>(
          create: (context) {
            return TimeLoggingBloc();
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
        BlocProvider<LeisureCubit>(
          lazy: true,
          create: (context) {
            var cubit = LeisureCubit();
            cubit.loadLeisureCategories();
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
        BlocProvider<SuggestedLeisureCubit>(
          create: (context) {
            var cubit = SuggestedLeisureCubit();
            cubit.init();
            return cubit;
          },
        ),
        BlocProvider<ThemeCubit>(create: (context) {
          ThemeState themeState = ThemeState.fromName(themeName);
          ThemeCubit themeCubit = ThemeCubit(initialState: themeState);
          // Make sure the shared Preferences are updated
          themeCubit.setToTheme(themeName);
          return themeCubit;
        }),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    NotificationApi.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) => MaterialApp(
        title: 'Lernbuddy',
        theme: state.themeData,
        home: const MyHomePage(),
      ),
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
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: IndexedStack(
          index: selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onItemTapped,
          unselectedItemColor: Theme.of(context).colorScheme.onBackgroundSoft,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          backgroundColor: Theme.of(context).colorScheme.cardColor,
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
      );
    });
  }
}
