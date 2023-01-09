import 'package:done/src/controllers/task_content_controller.dart';
import 'package:done/src/utils/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateItem extends StatelessWidget {
  const DateItem({
    Key? key,
  }) : super(key: key);

  Future<DateTime?> _showDatePicker(BuildContext context) {
    return showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(3000),
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskContentController = context.watch<TaskContentController>();

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 24,
      ),
      child: Row(
        children: [
          const Icon(Icons.today_rounded),
          const SizedBox(width: 16),
          taskContentController.time != null
              ? InputChip(
                  label: Text(
                    formatDate(taskContentController.time),
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                  onDeleted: () => taskContentController.updateTask(time: null),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: GestureDetector(
                    onTap: () async {
                      final time = await _showDatePicker(context);
                      taskContentController.updateTask(time: time);
                    },
                    child: Text(
                      'Add date',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
