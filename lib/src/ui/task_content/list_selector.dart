import 'package:done/src/ui/task_content/list_selection_bottom_sheet_content.dart';
import 'package:flutter/material.dart';

class ListSelector extends StatelessWidget {
  const ListSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 24,
        top: 4,
        bottom: 4,
      ),
      child: ElevatedButton(
        onPressed: () => _showListSelectionBottomSheet(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('List'),
            Icon(Icons.arrow_drop_down_rounded),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showListSelectionBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) => const ListSelectionBottomSheetContent(),
    );
  }
}
