import 'package:done/src/controllers/tasks_controller.dart';
import 'package:done/src/ui/home/completed_section.dart';
import 'package:done/src/ui/home/empty_body.dart';
import 'package:done/src/ui/home/progress_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesListBody extends StatelessWidget {
  const FavoritesListBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TasksController>();
    final tasks = controller
        .getTasksWithPredicate((element) => element.onFavorite == true);

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
}
