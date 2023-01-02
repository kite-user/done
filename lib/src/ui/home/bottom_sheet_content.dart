import 'package:done/src/controllers/tasks_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  var isShowDetailField = false;

  late TextEditingController _titleController;
  late TextEditingController _detailsController;

  @override
  initState() {
    super.initState();
    _titleController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _detailsController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  _setShowDetailField() {
    setState(() {
      isShowDetailField = !isShowDetailField;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasksController = context.watch<TasksController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
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
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.today_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.star_border_rounded),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: _titleController.text.isNotEmpty ||
                        _detailsController.text.isNotEmpty
                    ? () => tasksController
                        .createTask(_titleController.text)
                        .then((_) => Navigator.pop(context))
                    : null,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class DragHandle extends StatelessWidget {
  const DragHandle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 6,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
      ),
    );
  }
}
