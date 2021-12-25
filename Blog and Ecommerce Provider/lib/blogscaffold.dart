import "package:flutter/material.dart";

class BlogScaffold extends StatelessWidget {
  final List<Widget>? children;
  final AppBar? appbar;
  final Widget? floatingbutton;
  final Widget? storebody;
  BlogScaffold(
      {Key? key,
      this.children,
      this.floatingbutton,
      this.appbar,
      this.storebody})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar ?? AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        width: MediaQuery.of(context).size.width * 1,
        child: storebody ??
            SingleChildScrollView(
              // reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children ?? [],
              ),
            ),
      ),
      floatingActionButton: floatingbutton,
    );
  }
}
