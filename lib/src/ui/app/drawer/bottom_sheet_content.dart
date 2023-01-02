import 'package:done/src/controllers/tasklists_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  late TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final taskListsController = context.watch<TaskListsController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              const Text('Add list'),
              TextButton(
                onPressed: _inputController.text.isNotEmpty
                    ? () => taskListsController
                        .createList(_inputController.text)
                        .then((_) => Navigator.pop(context))
                    : null,
                child: const Text('Done'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _inputController,
            autofocus: true,
            textInputAction: TextInputAction.unspecified,
            decoration: const InputDecoration(
              hintText: 'Enter list title',
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
