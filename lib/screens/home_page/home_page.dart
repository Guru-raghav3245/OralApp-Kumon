import 'package:flutter/material.dart';
import 'package:oral_app2/question_logic/question_generator.dart';
import 'package:oral_app2/screens/home_page/drawer/drawer.dart'; // Import the custom drawer
import 'package:oral_app2/screens/home_page/drawer/settings_screen.dart'; // Import the settings screen

class StartScreen extends StatefulWidget {
  final Function(Operation) switchToPracticeScreen;

  const StartScreen(this.switchToPracticeScreen, {super.key});

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Operation _selectedOperation = Operation.addition; // Default operation

  void _navigateToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()), // Navigate to the settings screen
    );
  }

  void _navigateToHome() {
    Navigator.pop(context);
    Navigator.pop(context); 
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kumon Oral Practice'),
        backgroundColor: theme.colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the drawer
            },
          ),
        ],
      ),
      drawer: CustomDrawer(
        onHomePressed: _navigateToHome,
        onSettingsPressed: _navigateToSettings,
      ),
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            Image.asset(
              '/Users/Hacer/Desktop/flutter_projects/oral_app2/assets/kumon_logo.png', // Updated to relative path
              height: 50,
            ),
            const SizedBox(height: 20),
            Text(
              'Kumon Oral Practice',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 90),
            Image.asset(
              '/Users/Hacer/Desktop/flutter_projects/oral_app2/assets/speaker_logo.png', // Updated to relative path
              height: 150,
            ),
            const SizedBox(height: 150),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              iconAlignment: IconAlignment.end,
              onPressed: () {
                widget.switchToPracticeScreen(_selectedOperation);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              label: Text(
                'Start Oral Practice',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
              child: DropdownButtonFormField<Operation>(
                value: _selectedOperation,
                items: Operation.values.map(
                  (operation) => DropdownMenuItem(
                    value: operation,
                    child: Text(
                      operation.name.toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ).toList(),
                onChanged: (Operation? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedOperation = newValue;
                    });
                  }
                },
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2), // Red underline
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2), // Red underline when focused
                  ),
                  hintText: 'Choose an operation',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

