import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Center(
        child: Text(
          'Settings Screen',
          style: theme.textTheme.headlineSmall,
        ),
      ),
    );
  }
}
