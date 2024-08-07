import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';

class MapWidget extends StatelessWidget {
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(24.8599423, 67.0004351), // Karachi coordinates
    zoom: 11,
  );

  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);

    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        mapProvider.setMapController(controller);
      },
      initialCameraPosition: _initialPosition,
      markers: mapProvider.markers,
      myLocationEnabled: false,
      trafficEnabled: false,
      mapType: MapType.normal,
      liteModeEnabled: true,
    );
  }
}