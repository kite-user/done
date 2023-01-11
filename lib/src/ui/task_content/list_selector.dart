import 'package:done/src/controllers/task_content_controller.dart';
import 'package:done/src/controllers/tasklists_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListSelector extends StatelessWidget {
  const ListSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskContentController = context.watch<TaskContentController>();
    final taskListsController = context.watch<TaskListsController>();
    final currentListId = taskContentController.listId;
    String displayName = currentListId != null
        ? taskListsController.getList(currentListId).name
        : 'Not listed';

    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 24,
        top: 4,
        bottom: 4,
      ),
      child: ElevatedButton(
        onPressed: () async {
          return showModalBottomSheet(
            context: context,
            enableDrag: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            builder: (context) => ListSelectionBottomSheet(
                taskContentController: taskContentController),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(displayName),
            const Icon(Icons.arrow_drop_down_rounded),
          ],
        ),
      ),
    );
  }
}

class ListSelectionBottomSheet extends StatelessWidget {
  const ListSelectionBottomSheet({
    Key? key,
    required this.taskContentController,
  }) : super(key: key);

  final TaskContentController taskContentController;

  @override
  Widget build(BuildContext context) {
    final taskListsController = context.watch<TaskListsController>();
    final selection = taskListsController.tasklists;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Move task to',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: selection.length,
            itemBuilder: (_, index) {
              bool isCurrentListId =
                  selection[index].id == taskContentController.listId;
              return TextButton(
                onPressed: isCurrentListId
                    ? null
                    : () => taskContentController
                        .updateTask(listId: selection[index].id)
                        .then((_) => Navigator.pop(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selection[index].name),
                    isCurrentListId
                        ? const Icon(Icons.check_rounded)
                        : Container()
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
