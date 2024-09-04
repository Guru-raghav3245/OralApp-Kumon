import 'package:flutter/material.dart';
import 'package:oral_app2/question_logic/question_generator.dart';
import 'package:oral_app2/drawer/drawer.dart'; // Import the custom drawer
import 'package:oral_app2/drawer/settings_screen.dart'; // Import the settings screen

class StartScreen extends StatefulWidget {
  final Function(Operation, String) switchToPracticeScreen;

  const StartScreen(this.switchToPracticeScreen, {super.key});

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Operation _selectedOperation = Operation.addition; // Default operation
  String _selectedRange = 'Upto +5'; // Default range

  void _navigateToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const SettingsScreen()), // Navigate to the settings screen
    );
  }

  void _navigateToHome() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kumon Oral Practice', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: theme.colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _navigateToSettings, // Directly open settings
          ),
        ],
      ),
      drawer: CustomDrawer(
        onHomePressed: _navigateToHome,
        onSettingsPressed: _navigateToSettings,
      ),
      backgroundColor: theme.colorScheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Image.asset(
              '/Users/Hacer/Desktop/flutter_projects/oral_app2/assets/kumon_logo.png',
              height: 80,
            ),
            const SizedBox(height: 60),
            const Icon(
              Icons.volume_up, 
              size: 200,
              color: Colors.black),
            const SizedBox(height: 60),
            const Text(
              "Choose an Operation and Start Practicing",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: DropdownButtonFormField<Operation>(
                value: _selectedOperation,
                items: Operation.values.map((operation) {
                  return DropdownMenuItem(
                    value: operation,
                    child: Text(
                      operation.name.toUpperCase(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                }).toList(),
                onChanged: (Operation? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedOperation = newValue;
                      _selectedRange = _getDefaultRange(newValue);
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: theme.colorScheme.secondary, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SizedBox(
                width: 300,
                child: DropdownButtonFormField<String>(
                  value: _selectedRange,
                  items: _getDropdownItems(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedRange = newValue;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: theme.colorScheme.secondary, width: 2),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black), // Text color
                  dropdownColor: Colors.white, // Dropdown background color
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward, color: Colors.black,),
              onPressed: () {
                widget.switchToPracticeScreen(_selectedOperation, _selectedRange);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                backgroundColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              label: Text(
                'Start Oral Practice',
                style: theme.textTheme.titleMedium?.copyWith(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDefaultRange(Operation operation) {
    if (operation == Operation.addition) {
      return 'Upto +5';
    } else if (operation == Operation.subtraction) {
      return 'Subtract 5';
    } else if (operation == Operation.multiplication) {
      return 'Multiply by 5';
    } else if (operation == Operation.division) {
      return 'Divide by 5';
    } else {
      return 'Select an option'; // Default placeholder
    }
  }

  List<DropdownMenuItem<String>> _getDropdownItems() {
    if (_selectedOperation == Operation.addition) {
      return [
        const DropdownMenuItem(value: 'Upto +3', child: Text('Upto +3')),
        const DropdownMenuItem(value: 'Upto +5', child: Text('Upto +5')),
        const DropdownMenuItem(value: 'Upto +10', child: Text('Upto +10')),
      ];
    } else if (_selectedOperation == Operation.subtraction) {
      return [
        const DropdownMenuItem(value: 'Subtract 3', child: Text('Subtract 3')),
        const DropdownMenuItem(value: 'Subtract 5', child: Text('Subtract 5')),
      ];
    } else if (_selectedOperation == Operation.multiplication) {
      return [
        const DropdownMenuItem(value: 'Multiply by 3', child: Text('Multiply by 3')),
        const DropdownMenuItem(value: 'Multiply by 5', child: Text('Multiply by 5')),
      ];
    } else if (_selectedOperation == Operation.division) {
      return [
        const DropdownMenuItem(value: 'Divide by 3', child: Text('Divide by 3')),
        const DropdownMenuItem(value: 'Divide by 5', child: Text('Divide by 5')),
      ];
    } else {
      return [
        const DropdownMenuItem(value: 'Select an option', child: Text('Select an option')),
      ];
    }
  }
}
