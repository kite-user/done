import 'package:done/src/controllers/tasklists_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListSelectionBottomSheetContent extends StatelessWidget {
  const ListSelectionBottomSheetContent({
    Key? key,
  }) : super(key: key);

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
            itemBuilder: (_, index) => Text(selection[index].name),
          ),
        ],
      ),
    );
  }
}
