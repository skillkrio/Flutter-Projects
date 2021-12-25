import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class CounterApp extends StatelessWidget {
  CounterApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Counter>(
      create: (context) => Counter(),
      child: home(),
    );
  }
}

class home extends StatelessWidget {
  const home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counterobject = Provider.of<Counter>(context);
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              Text(counterobject._count.toString()),
              ElevatedButton(
                onPressed: () {
                  counterobject.increasecount();
                },
                child: Text("Increase"),
              ),
            ],
          ),
        ));
  }
}

class Counter extends ChangeNotifier {
  int _count = 0;

  int get getcount => _count;

  void increasecount() {
    _count++;
    notifyListeners();
  }
}
