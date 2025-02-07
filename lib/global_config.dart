import 'package:flutter/material.dart';

class GlobalConfig extends ChangeNotifier {
  Color primaryColor = Colors.blue; // 전역 색상

  void changeColor(Color newColor) {
    primaryColor = newColor;
    notifyListeners(); // UI 업데이트
  }
}
