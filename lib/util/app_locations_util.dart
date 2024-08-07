import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppLocationsUtil {
  // Karachi coordinates
  static const LatLng karachi = LatLng(24.8599423, 67.0004351);

  // Initial map position
  static const CameraPosition initialPosition = CameraPosition(
    target: karachi,
    zoom: 10,
  );

  // Other locations in Karachi
  static const List<LatLng> karachiLocations = [
    LatLng(24.861032, 66.887905),
    LatLng(24.944417, 66.904901),
    LatLng(24.992041, 67.072544),
    LatLng(24.904143, 67.087658),
    LatLng(25.0651679,66.9510601),
  ];

  // Add more locations or regions as needed
  // For example:
  // static const LatLng lahore = LatLng(31.5204, 74.3587);
  // static const LatLng islamabad = LatLng(33.6844, 73.0479);

  // Map style path
  static const String mapStylePath = 'assets/dark_theme.json';

  // Method to get random Karachi location
  static LatLng getRandomKarachiLocation() {
    return karachiLocations[DateTime.now().microsecond % karachiLocations.length];
  }
}