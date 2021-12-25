import "package:flutter/material.dart";

class Constrainedcenter extends StatelessWidget {
  final Widget child;

  const Constrainedcenter({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, //this will center the widget like css margin auto
      child: Center(
          //circle gets its width from partent i.e double.infinity this will cause expand the image so wrapping
          //it center helps to constrain the circleAvatar and place it in center
          child: child),
    );
  }
}
