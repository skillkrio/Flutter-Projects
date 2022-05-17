part of 'todos_filter_bloc.dart';

abstract class TodosFilterState extends Equatable {
  const TodosFilterState();

  @override
  List<Object> get props => [];
}

class TodosFilterLoading extends TodosFilterState {}

class TodosFilterLoaded extends TodosFilterState {
  List<Todo> filteredTodos;
  TodoFilterSort sortType;
  TodosFilterLoaded(
      {required this.filteredTodos, this.sortType = TodoFilterSort.pending});
  @override
  List<Object> get props => [filteredTodos, sortType];
}
