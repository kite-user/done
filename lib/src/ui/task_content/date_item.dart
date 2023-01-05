import 'package:flutter/material.dart';

class DateItem extends StatelessWidget {
  const DateItem({
    Key? key,
    required this.time,
  }) : super(key: key);

  final DateTime? time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 24,
        top: 16,
        bottom: 16,
      ),
      child: Row(
        children: [
          const Icon(Icons.today_rounded),
          const SizedBox(width: 16),
          if (time != null)
            InputChip(
              label: Text(
                'Wed, 14 Dec',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              onDeleted: () {},
              selected: false,
            )
          else
            GestureDetector(
              onTap: () {},
              child: Text(
                'Add date',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
        ],
      ),
    );
  }
}
