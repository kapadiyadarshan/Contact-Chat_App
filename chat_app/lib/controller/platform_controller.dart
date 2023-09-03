import 'dart:io';

import 'package:flutter/material.dart';

class PlatformController extends ChangeNotifier {
  bool isAndroid = Platform.isAndroid;

  changePlatform() {
    isAndroid = !isAndroid;
    notifyListeners();
  }
}
