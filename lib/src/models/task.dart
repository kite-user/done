import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String title;
  final String details;
  final DateTime? time;
  final bool completed;

  const Task({
    required this.id,
    required this.title,
    required this.details,
    this.time,
    this.completed = false,
  });

  @override
  List<Object?> get props => [completed, id, title, time, details];

  Task copyWith({
    int? id,
    String? title,
    String? details,
    bool? completed,
    DateTime? time,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      completed: completed ?? this.completed,
      time: time ?? this.time,
    );
  }
}
