import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practicelab/blocs/todos/todos_bloc.dart';
import 'package:practicelab/model/filter_todo_model.dart';
import 'package:practicelab/model/todoModel.dart';

part 'todos_filter_event.dart';
part 'todos_filter_state.dart';

class TodosFilterBloc extends Bloc<TodosFilterEvent, TodosFilterState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _todosSubscription;

  TodosFilterBloc({required TodosBloc todosbloc})
      : _todosBloc = todosbloc,
        super(TodosFilterLoading()) {
    on<UpdateTodosFilter>(_onUpdateTodosFilter);

    on<FilterUpdate>(_onFilterUpdate);
    _todosSubscription = todosbloc.stream.listen((state) {
      if (state is TodoLoaded) {
        add(FilterUpdate());
      }
    });
  }
  void _onFilterUpdate(FilterUpdate event, Emitter<TodosFilterState> emit) {
    final state = this.state;
    if (state is TodosFilterLoading) {
      add(UpdateTodosFilter(sortType: TodoFilterSort.pending));
    }

    if (state is TodosFilterLoaded) {
      final state = this.state as TodosFilterLoaded;
      add(UpdateTodosFilter(sortType: state.sortType));
    }
  }

  void _onUpdateTodosFilter(
      UpdateTodosFilter event, Emitter<TodosFilterState> emit) {
    TodosState state = _todosBloc.state;
    List<Todo> filteredTodos;
    if (state is TodoLoaded) {
      state = _todosBloc.state as TodoLoaded;
      filteredTodos = state.todos.where((todo) {
        switch (event.sortType) {
          case TodoFilterSort.all:
            return true;
          case TodoFilterSort.completed:
            return todo.isCompleted!;
          case TodoFilterSort.isCancelled:
            return todo.isCancelled!;
          case TodoFilterSort.pending:
            return !(todo.isCompleted! || todo.isCancelled!);
          default:
            return false;
        }
      }).toList();
      emit(TodosFilterLoaded(
          filteredTodos: filteredTodos, sortType: event.sortType));
    }
  }
}
