import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final Function switchScreen;

  const StartScreen(this.switchScreen, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10), // Space at the top
          Image.asset('/Users/Hacer/Desktop/flutter_projects/oral_app2/assets/kumon_logo.png',
            height: 50), // Smaller size for the logo)
            
          const SizedBox(height: 20),// Space between the logo and the title
           
          const Text(
            'Kumon Oral Practice',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 17, 16, 16),
            ),
          ),

          const SizedBox(height: 90), // Space between the title and the speaker icon

          Image.asset(
            '/Users/Hacer/Desktop/flutter_projects/oral_app2/assets/speaker_logo.png',
            height: 200, ),// Size for the speaker logo

          const SizedBox(height: 150), // Space between the speaker icon and the button

          ElevatedButton(
            onPressed: () {
              switchScreen();
            },
            child: const Text('Start Oral Practice', 
              style: TextStyle(color: Colors.black),)
          ),
        ],
      ),
    );
  }
}
