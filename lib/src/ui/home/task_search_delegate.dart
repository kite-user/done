import 'package:done/src/controllers/task_content_controller.dart';
import 'package:done/src/controllers/tasklists_controller.dart';
import 'package:done/src/controllers/tasks_controller.dart';
import 'package:done/src/models/task.dart';
import 'package:done/src/models/tasklist.dart';
import 'package:done/src/repository/app_repository.dart';
import 'package:done/src/repository/sqlite_repository.dart';
import 'package:done/src/ui/task_content/task_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskSearchDelegate extends SearchDelegate<String> {
  final AppRepository repository = SQLiteRepository.instance;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: query.isEmpty ? null : () => query = '',
        icon: const Icon(Icons.clear_rounded),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: repository.getTaskLists(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) return Container();
        final lists = snapshot.data;

        return FutureBuilder(
          future: repository.getTasks(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();

            final results = snapshot.data!
                .where(
                  (element) => element.title.contains(query),
                )
                .toList();

            return ListView.builder(
              shrinkWrap: true,
              itemCount: results.length,
              itemBuilder: (_, index) {
                final listIndex = lists!.indexWhere(
                  (element) => element.id == results[index].listId,
                );

                return ResultItem(
                  task: results[index],
                  list: lists[listIndex],
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: repository.getTaskLists(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) return Container();
        final lists = snapshot.data;

        return FutureBuilder(
          future: repository.getTasks(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();

            final results = snapshot.data!
                .where((element) => element.title.contains(query))
                .toList();

            return ListView.builder(
              shrinkWrap: true,
              itemCount: results.length,
              itemBuilder: (_, index) {
                final listIndex = lists!.indexWhere(
                  (element) => element.id == results[index].listId,
                );
                return ResultItem(
                  task: results[index],
                  list: lists[listIndex],
                );
              },
            );
          },
        );
      },
    );
  }
}

class ResultItem extends StatelessWidget {
  const ResultItem({
    Key? key,
    required this.task,
    required this.list,
  }) : super(key: key);

  final Task task;
  final TaskList list;

  @override
  Widget build(BuildContext context) {
    final taskListsController = context.watch<TaskListsController>();
    final tasksController = context.watch<TasksController>();

    final id = task.id;
    final title = task.title;
    final listName = list.name;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => TaskContentController(
                taskListsController,
                tasksController,
                id,
              ),
              child: const TaskContentScreen(),
            ),
          ),
        ),
        child: Card(
          elevation: 0,
          child: ListTile(
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              listName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
