import 'package:cloud_firestore/cloud_firestore.dart';

class BlogPost {
  final String postname;
  final DateTime publisheddate;
  final String body;
  final String? id;
  final bool? isliked;

  BlogPost(
      {required this.postname,
      required this.publisheddate,
      required this.body,
      this.id,
      this.isliked});

  factory BlogPost.frommap(Map<String, dynamic> map, String docid) {
    return BlogPost(
        postname: map["postname"],
        publisheddate: map["publisheddate"].toDate(),
        body: map["body"],
        id: docid,
        isliked: map["isliked"] ?? false);
  }
  Map<String, dynamic> tomap() {
    return {
      "postname": postname,
      "publisheddate": Timestamp.fromDate(publisheddate),
      "body": body
    };
  }
}
