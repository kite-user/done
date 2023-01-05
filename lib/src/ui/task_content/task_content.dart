import 'package:done/src/controllers/tasks_controller.dart';
import 'package:done/src/ui/task_content/date_item.dart';
import 'package:done/src/ui/task_content/detail_item.dart';
import 'package:done/src/ui/task_content/headline_title.dart';
import 'package:done/src/ui/task_content/list_selector.dart';
import 'package:done/src/ui/task_content/subtasks_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskContentScreen extends StatelessWidget {
  const TaskContentScreen({super.key, required this.taskId});

  final String taskId;

  @override
  Widget build(BuildContext context) {
    final tasksController = context.watch<TasksController>();
    final task = tasksController.getTask(taskId);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => tasksController.update(
              task.id,
              onFavorite: !task.onFavorite,
            ),
            icon: task.onFavorite
                ? const Icon(Icons.star_rounded)
                : const Icon(Icons.star_border_rounded),
          ),
          IconButton(
            onPressed: () => tasksController
                .deleteTask(task.id)
                .then((_) => Navigator.pop(context)),
            icon: const Icon(Icons.delete_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: task.completed
            ? () => tasksController.update(task.id, completed: false)
            : () => tasksController
                .update(task.id, completed: true)
                .then((_) => Navigator.pop(context)),
        label: task.completed
            ? const Text('Mark uncompleted')
            : const Text('Mark completed'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListSelector(),
              const HeadlineTitle(),
              const DetailItem(),
              DateItem(time: task.time),
              const SubtasksItem(),
            ],
          ),
        ),
      ),
    );
  }
}
