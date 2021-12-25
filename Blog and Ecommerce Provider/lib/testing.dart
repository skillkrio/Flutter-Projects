import "package:flutter/material.dart";
import "package:provider/provider.dart";

import 'Models/testmodel.dart';

class Testing extends StatelessWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("i got printed buddy");
    // final value = context.watch<TestModel>();

    return Container(
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(context.watch<TestModel>().count.toString()),
            ElevatedButton(
              onPressed: () {},
              child: Text(context.watch<TestModel>().count.toString()),
            ),
          ]),
    );
  }
}
