import 'package:flutter/material.dart';

class SplashScreenController extends ChangeNotifier {
  bool isSplash = false;

  isSplashChanged() {
    isSplash = true;
    notifyListeners();
  }
}
