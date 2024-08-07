import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate_app_ui/model/models.dart';

class MapRepository {
  final Random _random = Random();
  late List<MarkerModel> _markerModel;

  MapRepository() {
    _markerModel = _generateRandomMarkerData();
  }

  Future<String> loadMapStyle(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString('assets/dark_theme.json');
  }

  List<MarkerModel> _generateRandomMarkerData() {
    final List<LatLng> basePositions = [
      const LatLng(24.861032, 66.887905),
      const LatLng(24.944417, 66.904901),
      const LatLng(24.992041, 67.072544),
      const LatLng(24.904143, 67.087658),
      const LatLng(24.904143, 67.087658),
      const LatLng(24.843459, 67.072534),
    ];

    return List.generate(basePositions.length, (i) {
      return MarkerModel(
        'marker_$i',
        basePositions[i],
        '${_random.nextInt(15)}.${_random.nextInt(99)} mn ₽',
      );
    });
  }

  List<MarkerModel> getRandomMarkerData() {
    return _markerModel;
  }

  MarkerModel? getMarkerDataById(String id) {
    try {
      return _markerModel.firstWhere((data) => data.id == id);
    } catch (e) {
      return null;
    }
  }
}