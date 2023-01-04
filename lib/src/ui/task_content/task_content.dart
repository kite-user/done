import 'package:done/src/models/task.dart';
import 'package:done/src/ui/task_content/date_item.dart';
import 'package:done/src/ui/task_content/detail_item.dart';
import 'package:done/src/ui/task_content/headline_title.dart';
import 'package:done/src/ui/task_content/list_selector.dart';
import 'package:done/src/ui/task_content/subtasks_item.dart';
import 'package:flutter/material.dart';

class TaskContentScreen extends StatelessWidget {
  const TaskContentScreen({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star_border_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.check_outlined),
        label: const Text('Mark as completed'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ListSelector(),
              HeadlineTitle(title: 'List item'),
              DetailItem(),
              DateItem(),
              SubtasksItem(),
            ],
          ),
        ),
      ),
    );
  }
}
