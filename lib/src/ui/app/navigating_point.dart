import 'package:done/src/ui/app/drawer/app_drawer.dart';
import 'package:done/src/ui/calendar/calendar_view.dart';
import 'package:done/src/ui/home/home_screen.dart';
import 'package:done/src/ui/settings/settings_view.dart';
import 'package:flutter/material.dart';

class NavigatingPoint extends StatefulWidget {
  const NavigatingPoint({
    Key? key,
  }) : super(key: key);

  @override
  State<NavigatingPoint> createState() => _NavigatingPointState();
}

class _NavigatingPointState extends State<NavigatingPoint> {
  int currentIndex = 0;

  final views = [
    const HomeScreen(),
    const CalendarScreen(),
    const SettingScreen(),
  ];

  _changeIndex(index) => setState(() {
        currentIndex = index;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: views[currentIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _changeIndex,
        selectedIndex: currentIndex,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.today),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

enum Screen { home, calendar, setting }
