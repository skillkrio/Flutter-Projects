import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  bool? isCompleted;
  bool? isCancelled;
  Todo(
      {required this.id,
      required this.title,
      required this.description,
      this.isCompleted = false,
      this.isCancelled = false});
  Todo copyWith(
      {String? id,
      String? title,
      String? description,
      bool? isCompleted,
      bool? isCancelled}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        description,
        isCompleted,
        isCancelled,
      ];

  static List<Todo> todos = [
    Todo(id: '1', title: 'Sample Todo 1', description: 'Todo 1 description'),
    Todo(id: '2', title: 'Sample Todo 2', description: 'Todo 2 description'),
    Todo(id: '3', title: 'Sample Todo 3', description: 'Todo 3 description'),
  ];
}
