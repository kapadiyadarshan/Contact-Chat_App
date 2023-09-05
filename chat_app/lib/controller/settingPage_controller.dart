import 'package:flutter/material.dart';

class SettingPageController extends ChangeNotifier {
  bool isProfileOn = false;

  profileOnOff() {
    isProfileOn = !isProfileOn;
    notifyListeners();
  }
}
