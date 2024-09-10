import 'package:flutter/material.dart';
import 'dart:async';
import 'package:oral_app2/question_logic/question_generator.dart';
import 'package:oral_app2/screens/practice_screen/quit_modal/quit_modal.dart'; // Import the QuitDialog

class PracticeScreen extends StatefulWidget {
  final Function(List<String>, List<bool>, int) switchToResultScreen;
  final VoidCallback switchToStartScreen;
  final Function(String) triggerTTS;
  final Operation selectedOperation;
  final String selectedRange;

  PracticeScreen(this.switchToResultScreen, this.switchToStartScreen,
      this.triggerTTS, this.selectedOperation, this.selectedRange,
      {super.key});

  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  List<int> numbers = [0, 0, 0];
  List<int> answerOptions = [];
  int correctAnswer = 0;
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
      numbers = QuestionGenerator().generateTwoRandomNumbers(
          widget.selectedOperation, widget.selectedRange);
      correctAnswer = numbers[2];
      answerOptions = [correctAnswer];
      while (answerOptions.length < 3) {
        int option = QuestionGenerator().generateRandomNumber();
        if (!answerOptions.contains(option)) {
          answerOptions.add(option);
        }
      }
      answerOptions.shuffle(); // Randomize answer options
    });
  }

  void checkAnswer(int selectedAnswer) {
    bool isCorrect = selectedAnswer == correctAnswer;

    setState(() {
      answeredQuestions.add(
          '${numbers[0]} ${_getOperatorSymbol(widget.selectedOperation)} ${numbers[1]} = $selectedAnswer (${isCorrect ? "Correct" : "Wrong, The correct answer is $correctAnswer"})');
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

  void _showQuitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return QuitDialog(
          onQuit: () {
            widget
                .switchToStartScreen(); // Call the function to switch to start screen
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String questionText =
        '${numbers[0]} ${_getOperatorSymbol(widget.selectedOperation)} ${numbers[1]} = ?';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Quiz'),
        backgroundColor: const Color(0xFF009DDC), // Kumon blue
        actions: [
          ElevatedButton(
            onPressed: () {}, // Show the quit dialog
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.black,
              shape: const CircleBorder(),
              // minimumSize: const Size(40, 40),
            ),
            child: const Icon(
              Icons.pause,
              size: 20,
            ),
          ),
          ElevatedButton(
            onPressed: _showQuitDialog, // Show the quit dialog
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: const CircleBorder(),
              // minimumSize: const Size(40, 40),
            ),
            child: const Icon(
              Icons.exit_to_app_rounded,
              size: 20,
            ),
          ),
          ElevatedButton(
            onPressed: endQuiz,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 10, 127, 22),
              // minimumSize: const Size(120, 40),
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
        ],
      ),
      body: Stack(
        children: [
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              checkAnswer(answerOptions[0]);
                              regenerateNumbers();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: theme.colorScheme.primary,
                            ),
                            child: Text(
                              answerOptions[0].toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              checkAnswer(answerOptions[1]);
                              regenerateNumbers();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: theme.colorScheme.primary,
                            ),
                            child: Text(
                              answerOptions[1].toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          checkAnswer(answerOptions[2]);
                          regenerateNumbers();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: theme.colorScheme.primary,
                        ),
                        child: Text(
                          answerOptions[2].toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
