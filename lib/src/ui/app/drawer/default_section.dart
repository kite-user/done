import 'package:done/src/ui/app/drawer/list_item.dart';
import 'package:done/src/ui/app/section_header.dart';
import 'package:flutter/material.dart';

class DefaultSection extends StatelessWidget {
  const DefaultSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SectionHeader(
          title: 'Default',
        ),
        ListItem(
          icon: Icon(Icons.light_mode_rounded),
          title: 'Today',
          badge: 12,
        ),
        ListItem(
          icon: Icon(Icons.star_border_rounded),
          title: 'Favorites',
          badge: 12,
        ),
        ListItem(
          icon: Icon(Icons.delete_outline_rounded),
          title: 'Trash',
          badge: 100,
        ),
      ],
    );
  }
}
