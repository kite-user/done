import 'package:done/src/ui/app/section_header.dart';
import 'package:flutter/material.dart';

class SubtasksItem extends StatelessWidget {
  const SubtasksItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Subtasks'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextButton(
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.add_rounded),
                SizedBox(width: 8),
                Text('Add subtask'),
              ],
            ),
          ),
        )
      ],
    );
  }
}
