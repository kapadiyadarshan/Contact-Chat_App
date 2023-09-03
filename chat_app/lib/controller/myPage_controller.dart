import 'package:flutter/foundation.dart';

class MyPageController extends ChangeNotifier {
  int currentIndex = 1;

  changePage({required int index}) {
    currentIndex = index;
    notifyListeners();
  }
}
