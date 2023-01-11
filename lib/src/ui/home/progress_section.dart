import 'package:done/src/controllers/tasks_controller.dart';
import 'package:done/src/ui/app/section_header.dart';
import 'package:done/src/ui/home/list_item.dart';
import 'package:done/src/utils/date_difference.dart';
import 'package:done/src/utils/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressSection extends StatelessWidget {
  const ProgressSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TasksController>();
    final List<DateTime> dates = [];

    if (controller.isEmpty) return Container();

    for (final task in controller.tasks) {
      if (task.time != null && !dates.contains(task.time!)) {
        dates.add(task.time!);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const NoDateTasks(),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dates.length,
          itemBuilder: (context, index) =>
              DateCategorizedTasks(date: dates[index]),
        ),
      ],
    );
  }
}

class DateCategorizedTasks extends StatelessWidget {
  const DateCategorizedTasks({
    super.key,
    required this.date,
  });

  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TasksController>();
    final list = controller.tasks
        .where((element) =>
            !element.completed &&
            element.time != null &&
            element.time!.compareTo(date) == 0)
        .toList();

    if (list.isEmpty) return Container();

    String label =
        getLabelFromDuration(calculateDifference(date, DateTime.now()));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: label.isEmpty ? formatDate(date) : label),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) => ListItem(task: list[index]),
        ),
      ],
    );
  }
}

class NoDateTasks extends StatelessWidget {
  const NoDateTasks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TasksController>();
    final list = controller.tasks
        .where((element) => !element.completed && element.time == null)
        .toList();

    if (list.isEmpty) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'No date'),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) => ListItem(
            task: list[index],
          ),
        )
      ],
    );
  }
}
