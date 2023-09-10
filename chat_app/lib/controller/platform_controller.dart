import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlatformController extends ChangeNotifier {
  late bool _isAndroid;

  late SharedPreferences preferences;

  PlatformController({required this.preferences});

  get getPlatform {
    _isAndroid = preferences.getBool("platform") ?? true;
    return _isAndroid;
  }

  changePlatform() {
    _isAndroid = !_isAndroid;
    preferences.setBool("platform", _isAndroid);
    notifyListeners();
  }
}
