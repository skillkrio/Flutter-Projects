import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicelab/blocs/todos/todos_bloc.dart';
import 'package:practicelab/blocs/todos_filter/todos_filter_bloc.dart';
import 'package:practicelab/model/filter_todo_model.dart';
import 'package:practicelab/model/todoModel.dart';
import 'package:practicelab/screens/addTodoPage.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);
  int screenRebuild = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              onTap: (int pageIndex) {
                switch (pageIndex) {
                  case 0:
                    context.read<TodosFilterBloc>().add(
                        UpdateTodosFilter(sortType: TodoFilterSort.pending));
                    break;
                  case 1:
                    context.read<TodosFilterBloc>().add(
                        UpdateTodosFilter(sortType: TodoFilterSort.completed));
                    break;
                }
              },
              tabs: const [
                Tab(
                  text: "Pending",
                ),
                Tab(
                  text: "Completed",
                ),
              ],
            ),
            title: Text("Bloc pattern ToDo App"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddTodoPage()));
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
          body: TabBarView(children: [
            _blocBuilder(context, "Pending"),
            _blocBuilder(context, "Completed"),
          ])),
    );
  }

  ///Blocconsumer builder rebuilds ui when receives a state from bloc and listener will
  ///listen to state changes and react some stuffs in Ui like snackbar,dialog,etc.
  BlocConsumer _blocBuilder(BuildContext context, String title) {
    return BlocConsumer<TodosFilterBloc, TodosFilterState>(
      listener: (context, TodosFilterState state) {
        if (state is TodosFilterLoaded) {
          if (state.filteredTodos.length > 0) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("${state.filteredTodos.length} todos"),
            ));
          }
        }
      },
      builder: (context, state) {
        if (state is TodosFilterLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TodosFilterLoaded) {
          print("screen rebuild" + (screenRebuild++).toString());
          return Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      _buildCard(state.filteredTodos[index], context),
                  itemCount: state.filteredTodos.length,
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text("Something went wrong"));
        }
      },
    );
  }

  Widget _buildCard(Todo todo, BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '# ${todo.id}  ${todo.title}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      ///sending event to TodosBloc using add method
                      context.read<TodosBloc>().add(
                          UpdateTodo(todo: todo.copyWith(isCompleted: true)));
                    },
                    icon: Icon(Icons.add_task)),
                IconButton(
                    onPressed: () {
                      context.read<TodosBloc>().add(DeleteTodo(todo: todo));
                    },
                    icon: Icon(Icons.cancel)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
