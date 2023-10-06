import 'package:flutter/material.dart';

class MySchedule with ChangeNotifier {
  String _name = "";

  set name(String newValue) {
    _name = newValue;
    notifyListeners();
  }
}
