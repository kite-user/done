import 'package:done/src/models/task.dart';
import 'package:done/src/ui/app/section_header.dart';
import 'package:done/src/ui/home/list_item.dart';
import 'package:flutter/material.dart';

class CompletedSection extends StatelessWidget {
  const CompletedSection({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final list = tasks
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
