import 'package:done/src/ui/app/drawer/list_item.dart';
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
        ListItem(
          id: 'today',
          title: 'Today',
          icon: Icon(Icons.light_mode_rounded),
          badge: 0,
        ),
        ListItem(
          id: 'favorites',
          title: 'Favorites',
          icon: Icon(Icons.star_border_rounded),
          badge: 0,
        ),
        ListItem(
          id: 'trash',
          title: 'Trash',
          icon: Icon(Icons.delete_outline_rounded),
          badge: 0,
        ),
      ],
    );
  }
}
