import 'package:flutter/material.dart';

class ProviderColor extends ChangeNotifier {
  bool isClick = false;

  void isFunction() {
    isClick = !isClick;
    notifyListeners();
  }
}
