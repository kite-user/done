import 'package:done/src/ui/app/section_header.dart';
import 'package:done/src/ui/home/list_item.dart';
import 'package:done/src/ui/home/search_bar.dart';
import 'package:flutter/material.dart';

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
            pinned: false,
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
                const SectionHeader(title: 'On Progress'),
                ListView.builder(
                  itemCount: 5,
                  itemBuilder: (_, __) => const ListItem(),
                ),
                const SectionHeader(title: 'Completed'),
                ListView.builder(
                  itemCount: 5,
                  itemBuilder: (_, __) => const ListItem(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
