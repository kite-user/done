import 'package:flutter/widgets.dart';

class AppState extends ChangeNotifier {
  Map<String, String> _currentList = {'id': 'today', 'name': 'Today'};

  String get currentListId => _currentList['id'] ?? '';
  String get currentListName => _currentList['name'] ?? '';
  List<String> get defaultId => ['today', 'favorites', 'trash'];

  void changeListId({id, name}) {
    _currentList = {'id': id, 'name': name};
    notifyListeners();
  }
}
