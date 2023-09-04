import 'package:flutter/material.dart';

class DateTimeController extends ChangeNotifier {
  DateTime? d;
  TimeOfDay? t;

  dateChanged({required DateTime date}) {
    d = date;
    notifyListeners();
  }

  timeChanged({required TimeOfDay time}) {
    t = time;
    notifyListeners();
  }
}
