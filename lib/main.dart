import 'package:flutter/material.dart';
import 'pages/Page2Screen.dart';
import 'pages/Page3Screen.dart';
import 'pages/HomeScreen.dart';
import 'pages/FlutterQuillScreen.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(
              count: count,
              onIncrement: incrementCounter,
              onReset: resetCounter,
            ),
        '/page2': (context) => Page2Screen(),
        '/page3': (context) => Page3Screen(),
        '/flutter-quill': (context) => FlutterQuillScreen(),
      },
    );
  }

  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  void resetCounter() {
    setState(() {
      count = 0;
    });
  }
}
