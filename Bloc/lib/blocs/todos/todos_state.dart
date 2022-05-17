part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosLoading extends TodosState {}

class TodoLoaded extends TodosState {
  List<Todo> todos;
  TodoLoaded({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}
