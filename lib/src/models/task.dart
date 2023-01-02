import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String? details;
  final DateTime? time;
  final bool completed;
  final bool onFavorite;

  const Task({
    required this.id,
    required this.title,
    this.details,
    this.time,
    this.completed = false,
    this.onFavorite = false,
  });

  @override
  List<Object?> get props => [completed, onFavorite, id, title, time, details];

  Task copyWith({
    String? id,
    String? title,
    String? details,
    DateTime? time,
    bool? completed,
    bool? onFavorite,
  }) {
    return Task(
      id: id ?? const Uuid().v4(),
      title: title ?? this.title,
      details: details ?? this.details,
      time: time ?? this.time,
      completed: completed ?? this.completed,
      onFavorite: onFavorite ?? this.onFavorite,
    );
  }
}
