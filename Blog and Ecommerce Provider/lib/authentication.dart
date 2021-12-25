import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class Authentication extends StatelessWidget {
  Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailcontroller = TextEditingController();
    final TextEditingController passwordcontroller = TextEditingController();
    final errorNotifier = ValueNotifier<String>("");
    return Dialog(
      child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: passwordcontroller,
                  decoration: InputDecoration(labelText: "password"),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      final email = emailcontroller.text;
                      final password = passwordcontroller.text;
                      if (email.isEmpty || password.isEmpty) {
                        errorNotifier.value = "Fields Can't be Empty";
                        return;
                      }

                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email, password: password)
                          .then((value) => Navigator.of(context).pop())
                          .catchError((error) {
                        if (error! is FirebaseAuthException) {
                          return errorNotifier.value = error.message;
                        }
                      });
                    },
                    child: Text("Login", style: TextStyle(color: Colors.white)),
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: errorNotifier,
                  builder: (context, value, child) {
                    if (value.toString().isEmpty) {
                      return const SizedBox();
                    }
                    return Provider<String>.value(
                      value: value.toString(),
                      child: Error(),
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }
}

class Error extends StatelessWidget {
  const Error({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<String>(context);
    return Text(value);
  }
}
