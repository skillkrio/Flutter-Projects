part of 'todos_filter_bloc.dart';

abstract class TodosFilterEvent extends Equatable {
  const TodosFilterEvent();

  @override
  List<Object> get props => [];
}

class FilterUpdate extends TodosFilterEvent {
  const FilterUpdate();
  @override
  List<Object> get props => [];
}

class UpdateTodosFilter extends TodosFilterEvent {
  final TodoFilterSort sortType;

  UpdateTodosFilter({this.sortType = TodoFilterSort.pending});

  @override
  List<Object> get props => [sortType];
}

///FilterUpdate is used to verify in which tab we are currently in before emitting state to the Ui.
