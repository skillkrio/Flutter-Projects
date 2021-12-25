import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:playground/blog_post.dart';
import 'package:playground/blogscaffold.dart';
import 'package:playground/constrainedcenter.dart';
import 'package:playground/likebutton.dart';
import 'package:playground/likenotifier.dart';
import 'package:playground/user.dart';
import 'package:provider/provider.dart';

class BlogPage extends StatelessWidget {
  final BlogPost blogpost;
  const BlogPage({Key? key, required this.blogpost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BlogUser>(context);
    final likestatus = Provider.of<LikeNotifier>(context);
    return BlogScaffold(
      children: [
        Constrainedcenter(
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.profileurl),
            radius: 60,
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
          height: 40,
        ),
        SelectableText(
          blogpost.postname,
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              DateFormat("d MMMM y").format(blogpost.publisheddate),
              style: Theme.of(context).textTheme.caption,
            ),
            LikeButton(likestatus: likestatus),
          ],
        ),
        SizedBox(height: 20),
        SelectableText(
          blogpost.body,
          style: Theme.of(context).textTheme.headline5,
        )
      ],
    );
  }
}
