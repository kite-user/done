import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.badge,
    this.active = false,
  }) : super(key: key);

  final String title;
  final int badge;
  final Icon icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: active ? Theme.of(context).colorScheme.secondaryContainer : null,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 16,
          bottom: 16,
          right: 24,
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${badge > 99 ? '99+' : badge}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
