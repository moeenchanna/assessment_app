import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate_app_ui/model/models.dart';
import 'package:real_estate_app_ui/util/utils.dart';

class MapRepository {
  final Random _random = Random();
  late List<MarkerModel> _markerModel;

  MapRepository() {
    _markerModel = _generateRandomMarkerData();
  }

  Future<String> loadMapStyle(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString(AppLocationsUtil.mapStylePath);
  }

  List<MarkerModel> _generateRandomMarkerData() {
    return List.generate(AppLocationsUtil.karachiLocations.length, (i) {
      return MarkerModel(
        'marker_$i',
        AppLocationsUtil.karachiLocations[i],
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