import 'package:done/src/controllers/task_content_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailItem extends StatelessWidget {
  const DetailItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskContentController = context.watch<TaskContentController>();

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
      ),
      child: Row(
        children: [
          const Icon(Icons.menu_rounded),
          const SizedBox(width: 16),
          Expanded(
            child: TextFormField(
              initialValue: taskContentController.taskDetails,
              onChanged: (value) =>
                  taskContentController.updateTask(details: value),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Add details',
                hintStyle: Theme.of(context).textTheme.bodyLarge,
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
