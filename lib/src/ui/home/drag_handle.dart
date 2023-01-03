import 'package:flutter/material.dart';

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
