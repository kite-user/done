import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String? details;
  final DateTime? time;
  final bool completed;
  final bool onFavorite;
  final String? listId;
  final bool onTrash;

  const Task({
    required this.id,
    required this.title,
    this.details,
    this.time,
    this.completed = false,
    this.onFavorite = false,
    this.onTrash = false,
    this.listId,
  });

  @override
  List<Object?> get props => [
        completed,
        onFavorite,
        id,
        title,
        time,
        details,
        onTrash,
      ];

  Task copyWith({
    String? id,
    String? title,
    String? details,
    String? listId,
    DateTime? time,
    bool? completed,
    bool? onFavorite,
  }) {
    return Task(
      id: id ?? const Uuid().v4(),
      title: title ?? this.title,
      details: details ?? this.details,
      listId: listId ?? this.listId,
      time: time ?? this.time,
      completed: completed ?? this.completed,
      onFavorite: onFavorite ?? this.onFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'time': time != null ? time.toString() : '',
      'completed': completed,
      'favorited': onFavorite,
      'list_id': listId,
      'trash': onTrash,
    };
  }

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        details: json['details'],
        time: json['time'] == '' ? null : DateTime.parse(json['time']),
        completed: json['completed'] == 1,
        onFavorite: json['favorited'] == 1,
      );
}
