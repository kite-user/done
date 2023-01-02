import 'package:done/src/controllers/tasks_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.id,
    required this.title,
    this.subtitle,
    this.checked = false,
    this.onFavorite = false,
  }) : super(key: key);

  final String id;
  final String title;
  final String? subtitle;
  final bool checked;
  final bool onFavorite;

  @override
  Widget build(BuildContext context) {
    final tasksController = context.watch<TasksController>();

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
      child: ListTile(
        leading: IconButton(
          icon: checked
              ? const Icon(Icons.check_box_rounded)
              : const Icon(Icons.check_box_outline_blank_rounded),
          onPressed: () => tasksController.update(id, completed: !checked),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                decoration: checked ? TextDecoration.lineThrough : null,
                decorationThickness: 2,
              ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      decoration: checked ? TextDecoration.lineThrough : null,
                      decorationThickness: 1.5,
                    ),
              )
            : null,
        trailing: IconButton(
          icon: onFavorite
              ? const Icon(Icons.star_rounded)
              : const Icon(Icons.star_border_rounded),
          onPressed: () => tasksController.update(id, onFavorite: !onFavorite),
        ),
      ),
    );
  }
}
