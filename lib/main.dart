import 'package:flutter/material.dart';
import 'package:oral_app2/screens/start_screen.dart';
import 'package:oral_app2/screens/practice_screen.dart';
import 'package:oral_app2/screens/result_screen.dart';

void main() {
  runApp(MyApp());
}   

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  String activeScreen = 'start_screen';

  void switchToPracticeScreen() {
    setState(() {
      activeScreen = 'practice_screen';
    });
  }

  void switchToStartScreen() {
    setState(() {
      activeScreen = 'start_screen';
    });
  }

  void switchToResultScreen() {
    setState(() {
      activeScreen = 'result_screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF009DDC), // Kumon blue color
        body: activeScreen == 'start_screen'
            ? StartScreen(switchToPracticeScreen)
            : activeScreen == 'practice_screen'
                ? PracticeScreen(switchToStartScreen, switchToResultScreen)
                : ResultScreen(switchToStartScreen),
      ),
    );
  }
}
