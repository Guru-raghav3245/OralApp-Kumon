import 'package:flutter/material.dart';
import 'dart:async';
import 'package:oral_app2/question_logic/question_generator.dart';
import 'package:oral_app2/question_logic/question_checker.dart';
import 'package:oral_app2/modal/quit_modal.dart'; // Import the quit_modal.dart

class PracticeScreen extends StatefulWidget {
  final Function(List<String>, List<bool>, int) switchToResultScreen;
  final Function(String) triggerTTS;
  final Operation selectedOperation;
  final String selectedRange;

  const PracticeScreen(
      this.switchToResultScreen, this.triggerTTS, this.selectedOperation, this.selectedRange,
      {super.key});

  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  List<int> numbers = [0, 0, 0];
  final _textController = TextEditingController();
  String resultText = '';
  List<String> answeredQuestions = [];
  List<bool> answeredCorrectly = [];

  Timer? _timer;
  int _secondsPassed = 0;

  @override
  void initState() {
    super.initState();
    regenerateNumbers();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsPassed++;
      });
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void regenerateNumbers() {
    setState(() {
      numbers = QuestionGenerator().generateTwoRandomNumbers(widget.selectedOperation, widget.selectedRange);
    });
  }

  void checkAnswer() {
    int userAnswer = int.parse(_textController.text);
    bool isCorrect = QuestionChecker.checkAnswer(userAnswer, numbers[2]) == "Correct";

    setState(() {
      answeredQuestions.add(
          '${numbers[0]} ${_getOperatorSymbol(widget.selectedOperation)} ${numbers[1]} = $userAnswer (${isCorrect ? "Correct" : "Wrong, The correct answer is ${numbers[2]}"})');
      answeredCorrectly.add(isCorrect);
    });
  }

  String _getOperatorSymbol(Operation operation) {
    if (operation == Operation.addition) {
      return '+';
    } else if (operation == Operation.subtraction) {
      return '-';
    } else if (operation == Operation.multiplication) {
      return 'x';
    } else if (operation == Operation.division) {
      return '÷';
    }
    return '';
  }

  void _triggerTTSSpeech() {
    String operatorWord = '';
    if (widget.selectedOperation == Operation.addition) {
      operatorWord = 'plus';
    } else if (widget.selectedOperation == Operation.subtraction) {
      operatorWord = 'minus';
    } else if (widget.selectedOperation == Operation.multiplication) {
      operatorWord = 'times';
    } else if (widget.selectedOperation == Operation.division) {
      operatorWord = 'divided by';
    }

    String questionText = '${numbers[0]} $operatorWord ${numbers[1]} equals?';
    widget.triggerTTS(questionText);
  }

  void endQuiz() {
    stopTimer();
    widget.switchToResultScreen(
        answeredQuestions, answeredCorrectly, _secondsPassed);
  }

  void quitQuiz() {
    stopTimer();
    Navigator.of(context)
        .popUntil((route) => route.isFirst); // Navigate back to the home screen
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String questionText =
        '${numbers[0]} ${_getOperatorSymbol(widget.selectedOperation)} ${numbers[1]} = ?';

    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            child: ElevatedButton(
              onPressed: () {
                showQuitDialog(context, quitQuiz); // Pass the quit function
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.black,
                shape: const CircleBorder(),
                minimumSize: const Size(60, 60),
              ),
              child: const Icon(
                Icons.exit_to_app_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 150,
              height: 35,
              child: ElevatedButton(
                onPressed: endQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 10, 127, 22),
                ),
                child: const Text(
                  'Show Result',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 150,
              height: 35,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.restart_alt_rounded),
                onPressed: () {
                  checkAnswer();
                  regenerateNumbers();
                  _textController.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.onSurface,
                ),
                label: const Text(
                  'Next Question',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.speaker),
                iconSize: 150,
                color: Colors.black,
                onPressed: _triggerTTSSpeech,
              ),
              const SizedBox(height: 20),
              Text(
                questionText,
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _textController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'What\'s your answer?',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
