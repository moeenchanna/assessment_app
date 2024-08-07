import 'package:flutter/material.dart';

class MenuSelectionProvider extends ChangeNotifier {
  String _selectedItem = 'none';

  String get selectedItem => _selectedItem;

  void setSelectedItem(String value) {
    _selectedItem = value;
    notifyListeners();
  }
}