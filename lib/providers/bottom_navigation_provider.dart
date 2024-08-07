import 'package:flutter/material.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int _selectedIndex = 2; // Set the initial index to 2 for the HomeScreen

  int get selectedIndex => _selectedIndex;

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void notifyHideMenu() {
    notifyListeners();
  }
}