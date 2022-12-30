import 'package:done/src/ui/app/drawer/default_section.dart';
import 'package:done/src/ui/app/drawer/personal_section.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      DefaultSection(),
                      Divider(
                        thickness: 2,
                        indent: 16,
                        endIndent: 16,
                      ),
                      PersonalSection(
                        title: 'Personal',
                      )
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  top: 10,
                  bottom: 10,
                  right: 16,
                ),
                child: Row(
                  children: const [
                    Icon(Icons.add_rounded),
                    SizedBox(width: 8),
                    Text('Add '),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
