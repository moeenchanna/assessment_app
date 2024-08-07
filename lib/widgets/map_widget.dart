import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app_ui/util/utils.dart';
import '../providers/provider.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);

    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        mapProvider.setMapController(controller);
      },
      initialCameraPosition: AppLocationsUtil.initialPosition,
      markers: mapProvider.markers,
      myLocationEnabled: false,
      trafficEnabled: false,
      mapType: MapType.normal,
      liteModeEnabled: true,
    );
  }
}
