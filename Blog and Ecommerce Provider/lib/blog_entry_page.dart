import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:playground/blog_post.dart';
import 'package:playground/blogscaffold.dart';

class BlogEntryPage extends StatelessWidget {
  final BlogPost? post;
  BlogEntryPage({Key? key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isedit = post != null;
    final TextEditingController titlecontroller =
        TextEditingController(text: isedit ? post?.postname : "");

    final TextEditingController bodycontroller =
        TextEditingController(text: isedit ? post?.body : "");
    return BlogScaffold(
      children: [
        TextField(
          controller: titlecontroller,
          style: Theme.of(context).textTheme.headline1,
          decoration:
              InputDecoration(hintText: "Title", border: InputBorder.none),
        ),
        TextField(
          controller: bodycontroller,
          maxLines: null,
          style: Theme.of(context).textTheme.bodyText2,
          decoration: InputDecoration(
              hintText: "write your blog", border: InputBorder.none),
        ),
      ],
      floatingbutton: FloatingActionButton.extended(
        onPressed: () async {
          String title = titlecontroller.text;
          String body = bodycontroller.text;
          DateTime currenttime = DateTime.now();
          Map<String, dynamic> mapdata =
              BlogPost(postname: title, publisheddate: currenttime, body: body)
                  .tomap();
          if (isedit) {
            await FirebaseFirestore.instance
                .collection("blogposts")
                .doc(post!.id)
                .update(mapdata);
            print("inside edit");
            Navigator.of(context).pop();

            // edithandler(isedited: isedited, mappost: mappost, postobject: postobject)
          } else {
            await FirebaseFirestore.instance
                .collection("blogposts")
                .add(mapdata);
            print("works");
            Navigator.of(context).pop();
          }
          // edithandler(isedited: isedit, mappost: mapdata, postobject: post!);
          // await FirebaseFirestore.instance.collection("blogposts").add(mapdata);
        },
        label: Text(isedit ? "Update" : "submit"),
        icon: Icon(isedit ? Icons.check : Icons.book),
      ),
    );
  }
}
