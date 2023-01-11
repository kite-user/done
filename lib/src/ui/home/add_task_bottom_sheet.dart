import 'package:done/src/controllers/tasks_controller.dart';
import 'package:done/src/utils/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({
    Key? key,
    required this.listId,
  }) : super(key: key);

  final String listId;

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var isShowDetailField = false;

  late TextEditingController _titleController;
  late TextEditingController _detailsController;

  DateTime? currentDate;
  bool onFavorite = false;

  @override
  initState() {
    super.initState();
    currentDate = widget.listId == 'today' ? DateTime.now() : null;
    onFavorite = widget.listId == 'favorites';

    _titleController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _detailsController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  _setShowDetailField() => setState(() {
        isShowDetailField = !isShowDetailField;
      });

  _setOnFavorite() => setState(() {
        onFavorite = !onFavorite;
      });

  _setCurrentDate(DateTime? time) => setState(() {
        currentDate = time;
      });

  _addTask(TasksController controller) {
    return controller.createTask(
      title: _titleController.text,
      details: _detailsController.text,
      time: currentDate,
      onFavorite: onFavorite,
    );
  }

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
    final tasksController = context.watch<TasksController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _titleController,
              autofocus: true,
              textInputAction: TextInputAction.unspecified,
              decoration: const InputDecoration(
                hintText: 'New task',
                border: InputBorder.none,
              ),
            ),
          ),
          isShowDetailField
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _detailsController,
                    textInputAction: TextInputAction.unspecified,
                    decoration: const InputDecoration(
                      hintText: 'Details',
                      border: InputBorder.none,
                    ),
                  ),
                )
              : Container(),
          currentDate != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InputChip(
                    label: Text(
                      formatDate(currentDate),
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                    onDeleted: () => _setCurrentDate(null),
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    isSelected: isShowDetailField,
                    onPressed: _setShowDetailField,
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.menu_rounded),
                  ),
                  IconButton(
                    isSelected: currentDate != null,
                    onPressed: () async {
                      final time = await _showDatePicker(context);
                      _setCurrentDate(time);
                    },
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.today_rounded),
                  ),
                  IconButton(
                    isSelected: onFavorite,
                    onPressed: _setOnFavorite,
                    padding: EdgeInsets.zero,
                    icon: onFavorite
                        ? const Icon(Icons.star_rounded)
                        : const Icon(Icons.star_border_rounded),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: _titleController.text.isNotEmpty ||
                          _detailsController.text.isNotEmpty
                      ? () => _addTask(tasksController)
                          .then((_) => Navigator.pop(context))
                      : null,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
