import 'package:done/src/ui/settings/settings_item.dart';
import 'package:done/src/ui/settings/theme_screen.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SettingsItem(
                title: 'Theme',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThemeScreen()),
                ),
              ),
              const SettingsItem(
                title: 'Notifications',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
