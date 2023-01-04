import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {
  const DetailItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
        bottom: 16,
        right: 24,
      ),
      child: Row(
        children: [
          const Icon(Icons.chat_bubble_outline_rounded),
          const SizedBox(width: 16),
          Text(
            'Add details',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
