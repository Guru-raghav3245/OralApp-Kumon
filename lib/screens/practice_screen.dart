// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:oral_app2/question_logic/question_generator.dart';
import 'package:oral_app2/question_logic/question_checker.dart';

class PracticeScreen extends StatefulWidget {
  final Function switchToStartScreen;
  final Function switchToResultScreen;

  const PracticeScreen(this.switchToStartScreen, this.switchToResultScreen, {super.key});

  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  List<int> numbers = QuestionGenerator.generateTwoRandomNumbers();
  final _textController = TextEditingController();
  String resultText = ''; // Store "Correct" or "Wrong" result

  void regenerateNumbers() {
    setState(() {
      numbers = QuestionGenerator.generateTwoRandomNumbers();
      resultText = ''; // Clear result when generating new question
    });
  }

  void checkAnswer() {
    // Directly parse the user input and check it against the correct answer
    int userAnswer = int.parse(_textController.text);
    String result = QuestionChecker.checkAnswer(userAnswer, numbers[2]);
    setState(() {
      resultText = result; // Update the result text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 150,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  widget.switchToResultScreen();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 72, 59),
                ),
                child: const Text(
                  'Show Result',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
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
              child: ElevatedButton(
                onPressed: () {
                  checkAnswer(); // Check the user's answer
                  regenerateNumbers(); // Generate new numbers
                  _textController.clear(); // Clear the text field for the next input
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreenAccent,
                ),
                child: const Text(
                  'Next Question',
                  style: TextStyle(
                    color: Colors.black,
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
              Text(
                ' ${numbers[0]} + ${numbers[1]} = ?',
                style: const TextStyle(fontSize: 24),
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
              const SizedBox(height: 16),
              Text(
                resultText,
                style: const TextStyle(fontSize: 20, color: Colors.red), // Display the result ("Correct" or "Wrong")
              ),
            ],
          ),
        ),
      ],
    );
  }
}
