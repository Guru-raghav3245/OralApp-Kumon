import 'package:flutter/material.dart';

class QuitDialog extends StatelessWidget {
  final VoidCallback onQuit;

  const QuitDialog({super.key, required this.onQuit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Do you want to quit the quiz?',
        style: TextStyle(color: Color(0xFF009DDC)), // Kumon blue
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Pop the current route off the navigation stack
          },
          child: const Text(
            'Quit',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Pop the current route off the navigation stack
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }
}