import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  set selectedTab(int value) {
    _selectedTab = value;
    notifyListeners();
  }
}
