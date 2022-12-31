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
            final title = list[index].title;
            final details = list[index].details;
            final completed = list[index].completed;
            final onFavorite = list[index].onFavorite;

            return ListItem(
              title: title,
              subtitle: details,
              checked: completed,
              onFavorite: onFavorite,
            );
          },
        ),
      ],
    );
  }
}