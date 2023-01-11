import 'package:done/src/models/task.dart';
import 'package:done/src/ui/app/section_header.dart';
import 'package:done/src/ui/home/list_item.dart';
import 'package:done/src/utils/date_difference.dart';
import 'package:done/src/utils/date_format.dart';
import 'package:flutter/material.dart';

class ProgressSection extends StatelessWidget {
  const ProgressSection({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final List<DateTime> dates = [];

    if (tasks.isEmpty) return Container();

    for (final task in tasks) {
      if (task.time != null && !dates.contains(task.time!)) {
        dates.add(task.time!);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NoDateTasks(tasks: tasks),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dates.length,
          itemBuilder: (context, index) => DateCategorizedTasks(
            tasks: tasks,
            date: dates[index],
          ),
        ),
      ],
    );
  }
}

class DateCategorizedTasks extends StatelessWidget {
  const DateCategorizedTasks({
    super.key,
    required this.date,
    required this.tasks,
  });

  final DateTime date;
  final List<Task> tasks;
  @override
  Widget build(BuildContext context) {
    final list = tasks
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
    required this.tasks,
  }) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final list = tasks
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
          itemBuilder: (context, index) => ListItem(task: list[index]),
        )
      ],
    );
  }
}
