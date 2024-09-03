import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onQuit;
  final VoidCallback onResult;
  final VoidCallback onNextQuestion;

  const ActionButtons({
    required this.onQuit,
    required this.onResult,
    required this.onNextQuestion,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            child: ElevatedButton(
              onPressed: onQuit,
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
                onPressed: onResult,
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
                onPressed: onNextQuestion,
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
      ],
    );
  }
}
