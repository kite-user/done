import 'package:done/src/models/task.dart';
import 'package:equatable/equatable.dart';

class TaskList extends Equatable {
  final int id;
  final String name;
  final List<Task> tasks = [];

  TaskList({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name, tasks.length];
}
