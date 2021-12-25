import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import 'package:playground/blog_entry_page.dart';
import "package:playground/blog_post.dart";
import 'package:playground/blogpage.dart';
import 'package:playground/likenotifier.dart';
import 'package:playground/user.dart';
import 'package:provider/provider.dart';

import 'likebutton.dart';

class Bloglisttile extends StatelessWidget {
  final BlogPost post;
  const Bloglisttile({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isuserloggedin = Provider.of<BlogUser>(context).isloggedin;
    return ChangeNotifierProvider<LikeNotifier>(
      create: (context) => LikeNotifier(post: post)..init(),
      child: Builder(builder: (context) {
        final likestatus = Provider.of<LikeNotifier>(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: Text(
                post.postname,
                style: TextStyle(
                  color: Colors.blueAccent.shade200,
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ChangeNotifierProvider<LikeNotifier>.value(
                    value: likestatus,
                    child: BlogPage(
                      blogpost: post,
                    ),
                  );
                }));
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableText(
                  DateFormat("d MMMM y").format(post.publisheddate),
                  style: Theme.of(context).textTheme.caption,
                ),
                if (!isuserloggedin) LikeButton(likestatus: likestatus),
                if (isuserloggedin)
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Text("Edit"),
                          value: Action.edit,
                        ),
                        PopupMenuItem(
                            child: Text("Delete"), value: Action.delete),
                      ];
                    },
                    onSelected: (value) {
                      switch (value) {
                        case Action.edit:
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BlogEntryPage(
                              post: post,
                            );
                          }));
                          break;
                        case Action.delete:
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                    contentPadding: EdgeInsets.all(18),
                                    children: [
                                      Text(
                                          "Are you sure to delete this blogpost"),
                                      Text(
                                        post.postname,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              child: Text("Delete"),
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection("blogposts")
                                                    .doc(post.id)
                                                    .delete()
                                                    .then((value) =>
                                                        Navigator.of(context)
                                                            .pop());
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.redAccent),
                                            ),
                                            SizedBox(width: 10),
                                            TextButton(
                                              child: Text("cancel"),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                            )
                                          ]),
                                    ]);
                              });
                          break;
                      }
                    },
                  ),
              ],
            ),
            Divider(
              thickness: 2,
            ),
          ],
        );
      }),
    );
  }
}

enum Action { edit, delete }
