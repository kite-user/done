import 'package:done/src/controllers/task_content_controller.dart';
import 'package:done/src/ui/task_content/date_item.dart';
import 'package:done/src/ui/task_content/detail_item.dart';
import 'package:done/src/ui/task_content/headline_title.dart';
import 'package:done/src/ui/task_content/list_selector.dart';
import 'package:done/src/ui/task_content/subtasks_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskContentScreen extends StatelessWidget {
  const TaskContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskContentController = context.watch<TaskContentController>();
    final completed = taskContentController.completed;
    final onFavorite = taskContentController.favorite;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () =>
                taskContentController.updateTask(onFavorite: !onFavorite),
            icon: onFavorite
                ? const Icon(Icons.star_rounded)
                : const Icon(Icons.star_border_rounded),
          ),
          IconButton(
            onPressed: () => taskContentController
                .deleteTask()
                .then((_) => Navigator.pop(context)),
            icon: const Icon(Icons.delete_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: completed
            ? () => taskContentController.updateTask(completed: false)
            : () => taskContentController.updateTask(completed: true).then(
                  (_) => Navigator.pop(context),
                ),
        label: completed
            ? const Text('Mark uncompleted')
            : const Text('Mark completed'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ListSelector(),
              HeadlineTitle(),
              DetailItem(),
              DateItem(),
              SubtasksItem(),
            ],
          ),
        ),
      ),
    );
  }
}
