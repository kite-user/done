import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  const ListItem({
    Key? key,
    this.checked = false,
    this.onFavorite = false,
  }) : super(key: key);

  final bool checked;
  final bool onFavorite;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late bool checked;
  late bool onFavorite;

  @override
  void initState() {
    super.initState();
    checked = widget.checked;
    onFavorite = widget.onFavorite;
  }

  void _setChecked() {
    setState(() {
      checked = !checked;
    });
  }

  void _setOnFavorite() {
    setState(() {
      onFavorite = !onFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const ValueKey('string'),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 12),
        color: Theme.of(context).colorScheme.errorContainer,
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.cancel_outlined,
          color: Theme.of(context).colorScheme.onErrorContainer,
        ),
      ),
      child: ListTile(
        leading: IconButton(
          icon: checked
              ? const Icon(Icons.check_box_rounded)
              : const Icon(Icons.check_box_outline_blank_rounded),
          onPressed: _setChecked,
        ),
        title: Text(
          'List item',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          'Supporting text',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: IconButton(
          icon: onFavorite
              ? const Icon(Icons.star_rounded)
              : const Icon(Icons.star_border_rounded),
          onPressed: _setOnFavorite,
        ),
      ),
    );
  }
}
