import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oral_app2/screens/home_page/home_page.dart';
import 'package:oral_app2/screens/practice_screen/practice_screen.dart';
import 'package:oral_app2/screens/result_screen.dart';
import 'package:oral_app2/question_logic/tts_translator.dart';
import 'package:oral_app2/question_logic/question_generator.dart';

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
  List<String> answeredQuestions = [];
  List<bool> answeredCorrectly = []; // New List to store whether the answers are correct or not
  int totalTimeInSeconds = 0;
  Operation _selectedOperation = Operation.addition; // Default operation

  void switchToPracticeScreen(Operation operation) {
    setState(() {
      _selectedOperation = operation;
      activeScreen = 'practice_screen';
    });
  }

  void switchToStartScreen() {
    setState(() {
      activeScreen = 'start_screen';
    });
  }

  void switchToResultScreen(List<String> questions, List<bool> correctAnswers, int time) {
    setState(() {
      answeredQuestions = questions;
      answeredCorrectly = correctAnswers; // Store whether each answer is correct
      totalTimeInSeconds = time;
      activeScreen = 'result_screen';
    });
  }

  void triggerTTS(String text) {
    TTSService().speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color(0xFF009DDC),
        primary: const Color(0xFF009DDC),
        secondary: Colors.red,
        surface: Colors.white,
        onSurface: Colors.black,
        error: Colors.red,
      ),
      textTheme: GoogleFonts.latoTextTheme(),
    );

    return MaterialApp(
      theme: theme,
      home: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: activeScreen == 'start_screen'
            ? StartScreen(switchToPracticeScreen)
            : activeScreen == 'practice_screen'
                ? PracticeScreen(
                    (questions, correctAnswers, time) => switchToResultScreen(questions, correctAnswers, time),
                    (text) => triggerTTS(text),
                    _selectedOperation
                  )
                : ResultScreen(answeredQuestions, answeredCorrectly, totalTimeInSeconds, switchToStartScreen),
      ),
    );
  }
}

