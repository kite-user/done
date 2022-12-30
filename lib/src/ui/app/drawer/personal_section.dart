import 'package:done/src/controllers/tasklists_controller.dart';
import 'package:done/src/ui/app/drawer/list_item.dart';
import 'package:done/src/ui/app/section_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalSection extends StatelessWidget {
  const PersonalSection({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TaskListsController>();
    final taskLists = controller.tasklists;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: title,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: taskLists.length,
          itemBuilder: (context, index) {
            return ListItem(
              icon: const Icon(Icons.note_rounded),
              title: taskLists[index].name,
              badge: 0,
            );
          },
        )
      ],
    );
  }
}
