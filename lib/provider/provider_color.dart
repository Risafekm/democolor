import 'package:flutter/material.dart';

class ProviderColor extends ChangeNotifier {
  bool isClick = false;

  void onFunction() {
    isClick = !isClick;
    notifyListeners();
  }
}
