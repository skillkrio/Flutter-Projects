import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'blog_post.dart';

class LikeNotifier extends ChangeNotifier {
  bool _isliked = false;
  final BlogPost post;
  LikeNotifier({required this.post});

  bool get isliked {
    return _isliked;
  }

  void init() {
    _isliked = post.isliked as bool;
  }

  void changestate() {
    _isliked = !_isliked;
    FirebaseFirestore.instance
        .collection("blogposts")
        .doc(post.id)
        .update({"isliked": _isliked});
    notifyListeners();
  }
}
