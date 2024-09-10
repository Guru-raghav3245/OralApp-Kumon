import 'package:flutter/material.dart';

class PauseDialog extends StatelessWidget {

  const PauseDialog({super.key});

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
            Navigator.pop(context); // Close the dialog

          },
          child: const Text(
            'Quit',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
