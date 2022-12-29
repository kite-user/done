import 'package:done/src/ui/app/drawer/default_section.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              DefaultSection(
                title: 'Default',
              ),
              Divider(
                thickness: 2,
                indent: 16,
                endIndent: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
