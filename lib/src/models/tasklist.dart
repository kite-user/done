import 'package:equatable/equatable.dart';

class TaskList extends Equatable {
  final String id;
  final String name;

  const TaskList({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
