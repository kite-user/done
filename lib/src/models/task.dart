import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String title;
  final String details;
  final bool completed;
  final DateTime? time;

  const Task({
    required this.id,
    required this.title,
    required this.details,
    this.time,
    this.completed = false,
  });

  @override
  List<Object?> get props => [completed, id, title, time, details];
}
