import 'package:done/src/controllers/task_content_controller.dart';
import 'package:done/src/controllers/tasklists_controller.dart';
import 'package:done/src/controllers/tasks_controller.dart';
import 'package:done/src/models/task.dart';
import 'package:done/src/ui/task_content/task_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const ValueKey('string'),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 12),
        color: Theme.of(context).colorScheme.errorContainer,
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.cancel_outlined,
          color: Theme.of(context).colorScheme.onErrorContainer,
        ),
      ),
      child: task.details == null || task.details!.isEmpty
          ? OneLineListTile(task: task)
          : TwoLineListTile(task: task),
    );
  }
}

class TwoLineListTile extends StatelessWidget {
  const TwoLineListTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    final taskListsController = context.watch<TaskListsController>();
    final tasksController = context.watch<TasksController>();

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => TaskContentController(
              taskListsController,
              tasksController,
              task.id,
            ),
            child: const TaskContentScreen(),
          ),
        ),
      ),
      child: ListTile(
        leading: IconButton(
          icon: task.completed
              ? const Icon(Icons.check_box_rounded)
              : const Icon(Icons.check_box_outline_blank_rounded),
          onPressed: () =>
              tasksController.update(task.id, completed: !task.completed),
        ),
        title: Text(
          task.title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                decoration: task.completed ? TextDecoration.lineThrough : null,
                decorationThickness: 2,
              ),
        ),
        subtitle: Text(
          task.details!,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                decoration: task.completed ? TextDecoration.lineThrough : null,
                decorationThickness: 1.5,
              ),
        ),
        trailing: IconButton(
          icon: task.onFavorite
              ? const Icon(Icons.star_rounded)
              : const Icon(Icons.star_border_rounded),
          onPressed: () =>
              tasksController.update(task.id, onFavorite: !task.onFavorite),
        ),
      ),
    );
  }
}

class OneLineListTile extends StatelessWidget {
  const OneLineListTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    final taskListsController = context.watch<TaskListsController>();
    final tasksController = context.watch<TasksController>();

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => TaskContentController(
              taskListsController,
              tasksController,
              task.id,
            ),
            child: const TaskContentScreen(),
          ),
        ),
      ),
      child: ListTile(
        leading: IconButton(
          icon: task.completed
              ? const Icon(Icons.check_box_rounded)
              : const Icon(Icons.check_box_outline_blank_rounded),
          onPressed: () =>
              tasksController.update(task.id, completed: !task.completed),
        ),
        title: Text(
          task.title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                decoration: task.completed ? TextDecoration.lineThrough : null,
                decorationThickness: 2,
              ),
        ),
        trailing: IconButton(
          icon: task.onFavorite
              ? const Icon(Icons.star_rounded)
              : const Icon(Icons.star_border_rounded),
          onPressed: () =>
              tasksController.update(task.id, onFavorite: !task.onFavorite),
        ),
      ),
    );
  }
}
