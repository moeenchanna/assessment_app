import 'package:flutter/material.dart';
import '../model/models.dart';
import '../repository/repositories.dart';

class HomeProvider with ChangeNotifier {
  final PropertyRepository _propertyRepository = PropertyRepository();
  final OfferRepository _offerRepository = OfferRepository();

  List<PropertyModel> _properties = [];
  List<OfferModel> _offers = [];
  final Map<String, bool> _slideCompleted = {};

  List<PropertyModel> get properties => _properties;
  List<OfferModel> get offers => _offers;

  HomeProvider() {
    _loadData();
  }

  void _loadData() {
    _properties = _propertyRepository.getProperties();
    _offers = _offerRepository.getOffers();
    notifyListeners();
  }

  void setSlideCompleted(String address) {
    _slideCompleted[address] = true;
    notifyListeners();
  }

  bool isSlideCompleted(String address) {
    return _slideCompleted[address] ?? false;
  }

  OfferModel getOfferByType(String type) {
    return _offers.firstWhere((offer) => offer.type == type);
  }
}