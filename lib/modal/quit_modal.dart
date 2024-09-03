import 'package:flutter/material.dart';

void showQuitDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents closing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Do you want to quit the quiz?',
          style: TextStyle(color: Color(0xFF009DDC))),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).popUntil((route) => route.isFirst); // Navigate back to the home screen
            },
            child: const Text('Quit',
              style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel',
              style: TextStyle(color: Colors.green)),
          ),
        ],
      );
    },
  );
}

