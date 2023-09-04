import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends ChangeNotifier {
  File? file;

  imageUpdate({required XFile f}) {
    file = f as File;
    notifyListeners();
  }
}
