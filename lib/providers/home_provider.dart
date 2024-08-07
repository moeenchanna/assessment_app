import 'package:flutter/material.dart';
import '../model/models.dart';

class HomeProvider with ChangeNotifier {
  int buyOffers = 1034;
  int rentOffers = 2212;
  List<Property> properties = [
    Property(
      address: 'Gladkova St., 25',
      imageUrl:
      'https://images.livspace-cdn.com/plain/https://jumanji.livspace-cdn.com/magazine/wp-content/uploads/sites/2/2022/09/20124936/Cover-3.jpg',
    ),
    Property(
      address: 'Gladkova St., 25',
      imageUrl:
      'https://i.pinimg.com/originals/1b/e6/b9/1be6b9c2434f0d2951316407829b98fc.jpg',
    ),
    Property(
      address: 'Gladkova St., 25',
      imageUrl:
      'https://images.livspace-cdn.com/plain/https://jumanji.livspace-cdn.com/magazine/wp-content/uploads/sites/2/2022/09/20124936/Cover-3.jpg',
    ),
  ];

  Map<String, bool> slideCompleted = {};

  void setSlideCompleted(String address) {
    slideCompleted[address] = true;
    notifyListeners();
  }

  bool isSlideCompleted(String address) {
    return slideCompleted[address] ?? false;
  }
}