import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
