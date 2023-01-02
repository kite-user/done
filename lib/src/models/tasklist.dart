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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory TaskList.fromMap(Map<String, dynamic> json) => TaskList(
        id: json['id'],
        name: json['name'],
      );
}
