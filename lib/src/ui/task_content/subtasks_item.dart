import 'package:done/src/controllers/task_content_controller.dart';
import 'package:done/src/models/sub_task.dart';
import 'package:done/src/ui/app/section_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubtasksItem extends StatelessWidget {
  const SubtasksItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TaskContentController>();
    final subTasks = controller.subTasks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Subtasks'),
        subTasks.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: subTasks.length,
                  itemBuilder: (_, index) => SubTaskItem(
                    item: subTasks[index],
                  ),
                ),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextButton(
            onPressed: () => controller.createEmptySubTask(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.add_rounded),
                SizedBox(width: 8),
                Text('Add subtask'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SubTaskItem extends StatelessWidget {
  const SubTaskItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SubTask item;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TaskContentController>();
    final completed = item.completed;
    final content = item.content;
    final id = item.id;

    return ListTile(
      leading: IconButton(
        onPressed: completed
            ? () => controller.updateSubTask(id, completed: false)
            : () => controller.updateSubTask(id, completed: true),
        icon: completed
            ? const Icon(Icons.check_box_rounded)
            : const Icon(Icons.check_box_outline_blank_rounded),
      ),
      title: TextFormField(
        initialValue: content,
        minLines: null,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              decoration: completed ? TextDecoration.lineThrough : null,
              decorationThickness: 1.5,
            ),
        onChanged: (value) => controller.updateSubTask(id, content: value),
        decoration: const InputDecoration(
          hintText: 'Add content',
          border: InputBorder.none,
        ),
      ),
      trailing: IconButton(
        onPressed: () => controller.deleteSubTask(id),
        icon: const Icon(Icons.close_rounded),
      ),
    );
  }
}
