import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practicelab/model/todoModel.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosLoading()) {
    on<LoadTodo>(_onLoadTodo);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<UpdateTodo>(_onUpdateTodo);
  }

  void _onLoadTodo(LoadTodo event, Emitter<TodosState> emit) {
    emit(TodoLoaded(todos: event.todos));
  }

  void _onAddTodo(AddTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      emit(TodoLoaded(todos: List.from(state.todos)..add(event.todo)));
    }
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      emit(TodoLoaded(todos: List.from(state.todos)..remove(event.todo)));
    }
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      List<Todo> todos = state.todos
          .map((todo) => todo.id == event.todo.id ? event.todo : todo)
          .toList();
      emit(TodoLoaded(todos: todos));
    }
  }
}

/// i have defined the event handler for the event and it will emit the state to the Ui.