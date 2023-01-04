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
        onPressed: () {},
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
}
