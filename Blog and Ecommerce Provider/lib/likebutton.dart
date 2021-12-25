import "package:flutter/material.dart";
import 'package:playground/likenotifier.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key? key,
    required this.likestatus,
  }) : super(key: key);

  final LikeNotifier likestatus;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
          primary: likestatus.isliked ? Colors.blue : Colors.black),
      onPressed: likestatus.changestate,
      icon: Icon(
        likestatus.isliked ? Icons.thumb_up : Icons.thumb_up_outlined,
        // color: Colors.blue,
      ),
      label: Text("Like"),
    );
  }
}
