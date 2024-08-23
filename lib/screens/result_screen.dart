import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Function switchToStartScreen;
  ResultScreen(this.switchToStartScreen, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF009DDC), 
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0), 
              child: ElevatedButton(
                onPressed: () {
                  switchToStartScreen();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  'Back to Start Screen',
                  style: TextStyle(
                    color: Colors.white, 
                  ),
                ),
              ),
            ),
          ),
          // Add other widgets here if needed
        ],
      ),
    );
  }
}

