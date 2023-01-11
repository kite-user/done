import 'package:done/src/controllers/tasks_controller.dart';
import 'package:done/src/ui/home/completed_section.dart';
import 'package:done/src/ui/home/empty_body.dart';
import 'package:done/src/ui/home/progress_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayListBody extends StatelessWidget {
  const TodayListBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TasksController>();
    final tasks = controller.getTasksWithPredicate(
        (element) => element.time != null && isToday(element.time));

    if (tasks.isEmpty) return const EmptyBody();

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          ProgressSection(tasks: tasks),
          CompletedSection(tasks: tasks),
        ],
      ),
    );
  }

  bool isToday(time) {
    final now = DateTime.now();
    final daysDifference = (now.difference(time).inMinutes / 3600).round();
    return daysDifference == 0;
  }
}
