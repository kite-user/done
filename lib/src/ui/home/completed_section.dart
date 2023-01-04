import 'package:done/src/controllers/tasks_controller.dart';
import 'package:done/src/ui/app/section_header.dart';
import 'package:done/src/ui/home/list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletedSection extends StatelessWidget {
  const CompletedSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TasksController>();
    final list = controller.tasks
        .where(
          (element) => element.completed,
        )
        .toList();

    if (list.isEmpty) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Completed'),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (_, index) {
            return ListItem(task: list[index]);
          },
        ),
      ],
    );
  }
}
