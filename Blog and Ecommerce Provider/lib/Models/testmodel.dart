import 'package:flutter/foundation.dart';

class TestModel extends ChangeNotifier {
  int count = 0;

  void increase() {
    count++;
    notifyListeners();
  }
}
