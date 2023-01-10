import 'package:done/src/models/task.dart';
import 'package:done/src/repository/app_repository.dart';
import 'package:done/src/repository/sqlite_repository.dart';
import 'package:flutter/material.dart';

class TaskSearchDelegate extends SearchDelegate<String> {
  final AppRepository repository = SQLiteRepository.instance;
  final List<Task> results = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.clear_rounded),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.arrow_back_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
