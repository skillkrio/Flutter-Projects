import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicelab/blocs/todos/todos_bloc.dart';
import 'package:practicelab/blocs/todos_filter/todos_filter_bloc.dart';
import 'package:practicelab/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ///BlocProvider provides bloc instance down the widget tree
        BlocProvider<TodosBloc>(
          create: (context) => TodosBloc()..add(LoadTodo()),
        ),
        BlocProvider(
            create: (context) => TodosFilterBloc(
                todosbloc: BlocProvider.of<TodosBloc>(context))),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: const Color(0xFF000A1F),
          appBarTheme: const AppBarTheme(color: Color(0xFF000A1F)),
        ),
        home: Homepage(),
      ),
    );
  }
}
