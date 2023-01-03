import 'package:done/src/controllers/app_state.dart';
import 'package:done/src/controllers/tasklists_controller.dart';
import 'package:done/src/ui/home/bottom_sheet_content.dart';
import 'package:done/src/ui/home/completed_section.dart';
import 'package:done/src/ui/home/progress_section.dart';
import 'package:done/src/ui/home/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final taskListController = context.watch<TaskListsController>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTaskBottomSheet(context),
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
            title: Text(appState.currentListName),
            centerTitle: true,
            leading: IconButton(
              onPressed: Scaffold.of(context).openDrawer,
              icon: const Icon(Icons.menu),
            ),
            actions: [
              !appState.defaultId.contains(appState.currentListId)
                  ? IconButton(
                      onPressed: () {
                        taskListController.deleteList(appState.currentListId);
                        appState.changeListId(id: 'today', name: 'Today');
                      },
                      icon: const Icon(Icons.delete_rounded),
                    )
                  : Container(),
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

  Future<dynamic> _showAddTaskBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      enableDrag: false,
      builder: (context) {
        return BottomSheet(
          enableDrag: false,
          onClosing: () {},
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          builder: (BuildContext context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const BottomSheetContent(),
            );
          },
        );
      },
    );
  }
}
