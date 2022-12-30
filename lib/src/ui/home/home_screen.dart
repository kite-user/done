import 'package:done/src/controllers/tasks_controller.dart';
import 'package:done/src/ui/app/section_header.dart';
import 'package:done/src/ui/home/list_item.dart';
import 'package:done/src/ui/home/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) {
              return const SizedBox(
                height: 200,
              );
            }),
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            elevation: 0,
            title: const Text('Today'),
            centerTitle: true,
            leading: IconButton(
              onPressed: Scaffold.of(context).openDrawer,
              icon: const Icon(Icons.menu),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz_rounded),
              )
            ],
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: SearchBar(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const ProgressSection(),
                const CompletedSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CompletedSection extends StatelessWidget {
  const CompletedSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TasksController>();
    final list = controller.tasks
        .where(
          (element) => element.completed,
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Completed'),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (_, index) {
            final title = list[index].title;
            final details = list[index].details;
            final completed = list[index].completed;
            final onFavorite = list[index].onFavorite;

            return ListItem(
              title: title,
              subtitle: details,
              checked: completed,
              onFavorite: onFavorite,
            );
          },
        ),
      ],
    );
  }
}

class ProgressSection extends StatelessWidget {
  const ProgressSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TasksController>();
    final list = controller.tasks
        .where(
          (element) => !element.completed,
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'On progress'),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (_, index) {
            final title = list[index].title;
            final details = list[index].details;
            final completed = list[index].completed;
            final onFavorite = list[index].onFavorite;

            return ListItem(
              title: title,
              subtitle: details,
              checked: completed,
              onFavorite: onFavorite,
            );
          },
        ),
      ],
    );
  }
}
