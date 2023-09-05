import 'package:flutter/material.dart';

class SettingPageController extends ChangeNotifier {
  bool isProfileOn = false;
  bool isDark = false;

  profileOnOff() {
    isProfileOn = !isProfileOn;
    notifyListeners();
  }

  changeTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
