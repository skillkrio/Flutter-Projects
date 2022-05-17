import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicelab/blocs/todos/todos_bloc.dart';
import 'package:practicelab/model/todoModel.dart';

class AddTodoPage extends StatelessWidget {
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  AddTodoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Todo "),
      ),

      ///here we are not rebuilding ui only reacting to the state of the bloc
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is TodoLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Todo added"),
              ),
            );
            Navigator.of(context).pop();
          }
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                buildTextField(
                  "ID",
                  idController,
                ),
                buildTextField(
                  "Title",
                  titleController,
                ),
                buildTextField(
                  "Description",
                  descriptionController,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      var todo = Todo(
                          id: idController.text,
                          description: descriptionController.text,
                          title: titleController.text);
                      context.read<TodosBloc>().add(AddTodo(todo: todo));
                    },
                    child: Text("Add Todo"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildTextField(String field, TextEditingController controller) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        field,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 8),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter $field",
          ),
        ),
      ),
    ]);
  }
}
