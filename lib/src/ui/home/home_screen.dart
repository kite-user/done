import 'package:done/src/controllers/app_state.dart';
import 'package:done/src/controllers/tasklists_controller.dart';
import 'package:done/src/ui/home/add_task_bottom_sheet.dart';
import 'package:done/src/ui/home/favorites_list/favorites_list_body.dart';
import 'package:done/src/ui/home/more_bottom_sheet.dart';
import 'package:done/src/ui/home/personal_list/personal_list_body.dart';
import 'package:done/src/ui/home/search_bar.dart';
import 'package:done/src/ui/home/task_search_delegate.dart';
import 'package:done/src/ui/home/today_list/today_list_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final taskListController = context.watch<TaskListsController>();
    final currentListId = appState.currentListId;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            _showAddTaskBottomSheet(context, appState.currentListId),
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
            title: Text(appState.currentListName),
            centerTitle: true,
            leading: IconButton(
              onPressed: Scaffold.of(context).openDrawer,
              icon: const Icon(Icons.menu),
            ),
            actions: [
              IconButton(
                onPressed: () => _showMoreBottomSheet(context),
                icon: const Icon(Icons.more_horiz_rounded),
              )
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(75),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: GestureDetector(
                  onTap: () => showSearch(
                    context: context,
                    delegate: TaskSearchDelegate(),
                  ),
                  child: const SearchBar(),
                ),
              ),
            ),
          ),
          if (currentListId == 'today')
            const TodayListBody()
          else if (currentListId == 'favorites')
            const FavoritesListBody()
          else
            const PersonalListBody()
        ],
      ),
    );
  }

  Future<dynamic> _showMoreBottomSheet(BuildContext context) {
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
              child: const MoreBottomSheet(),
            );
          },
        );
      },
    );
  }

  Future<dynamic> _showAddTaskBottomSheet(BuildContext context, String listId) {
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
              child: AddTaskBottomSheet(listId: listId),
            );
          },
        );
      },
    );
  }
}
