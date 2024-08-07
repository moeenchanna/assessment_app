import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerModel {
  final String id;
  final LatLng position;
  final String text;

  MarkerModel(this.id, this.position, this.text);
}