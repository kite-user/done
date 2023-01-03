import 'package:done/src/controllers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.id,
    required this.title,
    required this.icon,
    this.badge = 0,
  }) : super(key: key);

  final String id;
  final String title;
  final int badge;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return GestureDetector(
      onTap: () {
        appState.changeListId(id: id, name: title);
        Scaffold.of(context).closeDrawer();
      },
      child: Container(
        decoration: BoxDecoration(
          color: appState.currentListId == id
              ? Theme.of(context).colorScheme.secondaryContainer
              : null,
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
      ),
    );
  }
}
