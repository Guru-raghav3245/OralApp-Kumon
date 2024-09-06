import 'package:flutter/material.dart';

void showQuitDialog(BuildContext context, VoidCallback onQuit) {
  showDialog(
    context: context,
    barrierDismissible: true, // Prevent closing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Do you want to quit the quiz?',
          style: TextStyle(color: Color(0xFF009DDC)), // Kumon blue
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              onQuit(); // Execute the quit function
            },
            child: const Text(
              'Quit',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      );
    },
  );
}
