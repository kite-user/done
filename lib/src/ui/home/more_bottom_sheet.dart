import 'package:done/src/controllers/app_state.dart';
import 'package:done/src/controllers/tasklists_controller.dart';
import 'package:done/src/controllers/tasks_controller.dart';
import 'package:done/src/ui/home/rename_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoreBottomSheet extends StatelessWidget {
  const MoreBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final taskListsController = context.watch<TaskListsController>();
    final tasksController = context.watch<TasksController>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FunctionItem(
            title: 'Delete all completed tasks',
            onPressed: () async => await tasksController
                .deleteCompledTasksInCurrentList()
                .then((_) => Navigator.pop(context)),
          ),
          FunctionItem(
            title: 'Rename list',
            onPressed: appState.isDefaultId
                ? null
                : () async {
                    final String newName = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RenameScreen(initName: appState.currentListName),
                      ),
                    );

                    await taskListsController
                        .updateList(appState.currentListId, name: newName)
                        .then((_) => Navigator.pop(context));
                  },
          ),
          FunctionItem(
            title: 'Delete list',
            onPressed: appState.isDefaultId
                ? null
                : () async {
                    await taskListsController
                        .deleteList(appState.currentListId)
                        .then((_) => Navigator.pop(context));
                  },
          ),
        ],
      ),
    );
  }
}

class FunctionItem extends StatelessWidget {
  const FunctionItem({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
