import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class SubTask extends Equatable {
  final String id;
  final String content;
  final bool completed;
  final bool onTrash;
  final String taskId;

  const SubTask({
    required this.id,
    required this.content,
    required this.taskId,
    this.completed = false,
    this.onTrash = false,
  });

  @override
  List<Object?> get props => [id, content, completed, onTrash];

  SubTask copyWith({
    String? id,
    String? content,
    bool? completed,
    bool? onTrash,
    String? taskId,
  }) {
    return SubTask(
      id: id ?? const Uuid().v4(),
      content: content ?? this.content,
      completed: completed ?? this.completed,
      onTrash: onTrash ?? this.onTrash,
      taskId: taskId ?? this.taskId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'completed': completed ? 1 : 0,
      'trash': onTrash ? 1 : 0,
      'task_id': taskId,
    };
  }

  factory SubTask.fromMap(Map<String, dynamic> json) => SubTask(
        id: json['id'],
        content: json['content'],
        taskId: json['task_id'],
        completed: json['completed'] == 1,
      );
}
