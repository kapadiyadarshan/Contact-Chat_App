import 'package:flutter/material.dart';

class ImageController extends ChangeNotifier {
  String? path;

  imageUpdate({required String file}) {
    path = file;
    notifyListeners();
  }

  clearImage() {
    path = null;
    notifyListeners();
  }
}
