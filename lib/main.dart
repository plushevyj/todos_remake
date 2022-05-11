import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todos_remake/widgets/popup_add_task.dart';
import 'pages/tasks_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ru', ''),
      ],
      theme: CupertinoThemeData(
        primaryColor: Color(0xFF3BB75F),
        primaryContrastingColor: Color(0xFF3BB75F),
        textTheme:
            CupertinoTextThemeData(textStyle: TextStyle(fontFamily: 'Inter'), primaryColor: Color(0xFF000000)),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;

  final List<Widget> screens = [
    const TasksPage(),
    const TasksPage(),
    const SecondScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showPopup(),
        child: const Icon(CupertinoIcons.add),
        backgroundColor: const Color(0xFF3BB75F),
        splashColor: const Color(0x00FFFFFF),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          border: const Border(top: BorderSide.none),
          backgroundColor: const Color(0xFFF5F5F5),
          items: const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.list_bullet)),
            BottomNavigationBarItem(
              icon: Icon(null),
            ),
            BottomNavigationBarItem(icon: Icon(null)),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          if (index == 1) {
            currentTab = 0;
          } else {
            currentTab = index;
          }
          return screens[currentTab];
        },
      ),
    );
  }

  void showPopup() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return const PopupAddNewTask();
      },
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('2');
  }
}
