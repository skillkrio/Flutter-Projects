// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import 'package:playground/blog_entry_page.dart';
import "package:playground/blog_post.dart";
import 'package:playground/blogpage.dart';
import 'package:playground/blogscaffold.dart';
import "package:playground/constrainedcenter.dart";
import 'package:playground/user.dart';
import 'package:provider/provider.dart';
import 'package:playground/authentication.dart';
import 'package:playground/blog_list_tile.dart';

class Homepage extends StatelessWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<BlogPost>>(context);
    final user = Provider.of<BlogUser>(context);
    final isUserLoggedIn = Provider.of<BlogUser>(context).isloggedin;
    return BlogScaffold(
      appbar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.shopping_bag),
              onPressed: () {
                Navigator.of(context).pushNamed("/storepage");
              }),
          TextButton(
            child: Text(
              isUserLoggedIn ? "🚪" : "🔑",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              if (isUserLoggedIn) {
                FirebaseAuth.instance.signOut();
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Authentication();
                    });
              }
            },
          ),
        ],
      ),
      children: [
        Constrainedcenter(
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.profileurl),
            radius: 75,
          ),
        ),
        SizedBox(
          height: 18,
        ),
        Constrainedcenter(
          child: SelectableText(user.profiletitle,
              style: Theme.of(context).textTheme.headline2),
        ),
        SizedBox(
          height: 20,
        ),
        SelectableText(
          "Hey this is skillkrio.I am a Flutter GDE and also a Entrepreneur",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(
          height: 20,
        ),
        SelectableText(
          "Blog",
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          height: 20,
        ),
        for (var post in posts)
          Bloglisttile(
            post: post,
          ),
      ],
      floatingbutton: isUserLoggedIn
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return BlogEntryPage();
                    },
                  ),
                );
              },
              icon: Icon(Icons.add),
              label: Text("New Blog"),
              focusColor: Colors.red,
            )
          : SizedBox(),
    );
  }
}
