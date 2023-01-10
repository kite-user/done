import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  final SharedPreferences _prefs;

  AppState(this._prefs);
  List<String> get defaultId => ['today', 'favorites', 'trash'];

  Map<String, String> _currentList = {'id': 'today', 'name': 'Today'};
  String get currentListId => _currentList['id'] ?? '';
  String get currentListName => _currentList['name'] ?? '';

  late ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  void loadData() {
    _themeMode = ThemeMode.values.elementAt(_prefs.getInt('theme') ?? 0);
  }

  void changeListId({id, name}) {
    _currentList = {'id': id, 'name': name};
    notifyListeners();
  }

  Future<void> changeThemeMode(ThemeMode mode) async {
    await _prefs.setInt('theme', mode.index);
    _themeMode = mode;
    notifyListeners();
  }
}
